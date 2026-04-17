import type { Plugin } from "@opencode-ai/plugin";
import { readFile } from "fs/promises";
import { basename, resolve } from "path";

const PROTECTED_FIELDS = [
  "dependencies",
  "devDependencies",
  "peerDependencies",
  "optionalDependencies",
  "bundleDependencies",
  "bundledDependencies",
  "overrides",
  "resolutions",
  "catalog",
  "catalogs",
];

const MESSAGE = [
  "Manually editing dependency versions in package.json is not allowed.",
  "Your training data likely contains outdated package versions.",
  "Use the appropriate package manager command instead:\n",
  "  bun add <package>        bun remove <package>        bun update <package>",
  "  pnpm add <package>       pnpm remove <package>       pnpm update <package>",
  "  npm install <package>    npm uninstall <package>     npm update <package>",
  "  yarn add <package>       yarn remove <package>       yarn upgrade <package>\n",
  "This ensures you install the latest compatible version",
  "rather than a potentially outdated one from training data.",
].join("\n");

const APPLY_PATCH_MESSAGE = [
  "Could not safely inspect apply_patch changes to package.json.",
  "Use bun/pnpm/npm/yarn add, remove, or update instead of manually patching dependency versions.",
  "Do not rely on versions from training data.",
].join("\n");

function tryParse(text: string): Record<string, unknown> | null {
  try {
    return JSON.parse(text);
  } catch {
    return null;
  }
}

async function tryRead(path: string): Promise<string | null> {
  try {
    return await readFile(path, "utf-8");
  } catch {
    return null;
  }
}

function depsChanged(
  before: Record<string, unknown>,
  after: Record<string, unknown>,
): boolean {
  for (const field of PROTECTED_FIELDS) {
    if (JSON.stringify(before[field]) !== JSON.stringify(after[field])) {
      return true;
    }
  }
  const a = (before.pnpm as Record<string, unknown> | undefined)?.overrides;
  const b = (after.pnpm as Record<string, unknown> | undefined)?.overrides;
  return JSON.stringify(a) !== JSON.stringify(b);
}

function guard(before: Record<string, unknown>, after: Record<string, unknown>) {
  if (depsChanged(before, after)) throw new Error(MESSAGE);
}

// --- apply_patch helpers ---

interface PatchSection {
  action: string;
  path: string;
  lines: string[];
}

interface PatchHunk {
  oldStart: number | null;
  lines: string[];
}

function parsePatchSections(patchText: string): PatchSection[] {
  const sections: PatchSection[] = [];
  let current: PatchSection | null = null;

  for (const line of patchText.split("\n")) {
    const m = line.match(/^\*\*\*\s+(Add|Update|Delete)\s+File:\s+(.+)$/);
    if (m) {
      if (current) sections.push(current);
      current = { action: m[1], path: m[2].trim(), lines: [] };
      continue;
    }
    if (line.startsWith("***")) continue;
    if (current) current.lines.push(line);
  }
  if (current) sections.push(current);
  return sections;
}

function splitLines(text: string): string[] {
  if (!text) return [];
  return text.endsWith("\n")
    ? text.slice(0, -1).split("\n")
    : text.split("\n");
}

function parsePatchHunks(patchLines: string[]): PatchHunk[] | null {
  const hunks: PatchHunk[] = [];
  let current: PatchHunk | null = null;

  for (const line of patchLines) {
    const numbered = line.match(/^@@ -(\d+)(?:,(\d+))? \+(\d+)(?:,(\d+))? @@/);
    if (numbered) {
      if (current) hunks.push(current);
      current = { oldStart: Number(numbered[1]) - 1, lines: [] };
      continue;
    }

    if (/^@@(?: .*)?$/.test(line)) {
      if (current) hunks.push(current);
      current = { oldStart: null, lines: [] };
      continue;
    }

    if (!current) {
      if (!line) continue;
      return null;
    }

    current.lines.push(line);
  }

  if (current) hunks.push(current);
  return hunks.length > 0 ? hunks : null;
}

function matchHunkAt(
  originalLines: string[],
  start: number,
  hunkLines: string[],
): number | null {
  let index = start;

  for (const line of hunkLines) {
    if (line === "\\ No newline at end of file") continue;

    const kind = line[0];
    const content = line.slice(1);

    if (kind === " ") {
      if (originalLines[index] !== content) return null;
      index++;
      continue;
    }

    if (kind === "-") {
      if (originalLines[index] !== content) return null;
      index++;
      continue;
    }

    if (kind === "+") continue;
    return null;
  }

  return index;
}

function findHunkStart(
  originalLines: string[],
  from: number,
  hunkLines: string[],
): number | null {
  const anchor = hunkLines.find((line) => line.startsWith(" ") || line.startsWith("-"));
  if (!anchor) return null;

  const content = anchor.slice(1);
  for (let index = from; index < originalLines.length; index++) {
    if (originalLines[index] !== content) continue;
    if (matchHunkAt(originalLines, index, hunkLines) !== null) {
      return index;
    }
  }

  return null;
}

function applyHunkAt(
  originalLines: string[],
  start: number,
  hunkLines: string[],
): { lines: string[]; end: number } | null {
  const lines: string[] = [];
  let index = start;

  for (const line of hunkLines) {
    if (line === "\\ No newline at end of file") continue;

    const kind = line[0];
    const content = line.slice(1);

    if (kind === " ") {
      if (originalLines[index] !== content) return null;
      lines.push(originalLines[index]);
      index++;
      continue;
    }

    if (kind === "-") {
      if (originalLines[index] !== content) return null;
      index++;
      continue;
    }

    if (kind === "+") {
      lines.push(content);
      continue;
    }

    return null;
  }

  return { lines, end: index };
}

function applyPatch(original: string, patchLines: string[]): string | null {
  const hunks = parsePatchHunks(patchLines);
  if (!hunks) return null;

  const originalLines = splitLines(original);
  const result: string[] = [];
  let originalIndex = 0;

  for (const hunk of hunks) {
    const start =
      hunk.oldStart !== null
        ? hunk.oldStart
        : findHunkStart(originalLines, originalIndex, hunk.lines);

    if (start === null || start < originalIndex || start > originalLines.length) {
      return null;
    }

    result.push(...originalLines.slice(originalIndex, start));

    const applied = applyHunkAt(originalLines, start, hunk.lines);
    if (!applied) return null;

    result.push(...applied.lines);
    originalIndex = applied.end;
  }

  result.push(...originalLines.slice(originalIndex));
  return `${result.join("\n")}${original.endsWith("\n") ? "\n" : ""}`;
}

// --- plugin ---

export const PackageJsonProtection: Plugin = async ({ directory }) => {
  return {
    "tool.execute.before": async (input, output) => {
      // edit tool
      if (input.tool === "edit") {
        if (basename(output.args.filePath) !== "package.json") return;

        const raw = await tryRead(output.args.filePath);
        if (!raw) return;
        const before = tryParse(raw);
        if (!before) return;

        const { oldString, newString, replaceAll } = output.args;
        const edited = replaceAll
          ? raw.split(oldString).join(newString)
          : (() => {
              const i = raw.indexOf(oldString);
              return i === -1
                ? null
                : raw.slice(0, i) + newString + raw.slice(i + oldString.length);
            })();
        if (!edited) return;

        const after = tryParse(edited);
        if (!after) return;

        guard(before, after);
      }

      // write tool
      if (input.tool === "write") {
        if (basename(output.args.filePath) !== "package.json") return;

        const raw = await tryRead(output.args.filePath);
        const before = raw ? tryParse(raw) : null;
        const after = tryParse(output.args.content);
        if (!after) return;

        guard(before ?? {}, after);
      }

      // apply_patch tool (Codex-style patch)
      if (input.tool === "apply_patch") {
        for (const section of parsePatchSections(output.args.patchText)) {
          if (basename(section.path) !== "package.json") continue;
          const absPath = resolve(directory, section.path);

          if (section.action === "Add") {
            const content = section.lines
              .filter((l) => l.startsWith("+"))
              .map((l) => l.slice(1))
              .join("\n");
            const after = tryParse(content);
            if (after) guard({}, after);
          }

          if (section.action === "Update") {
            const raw = await tryRead(absPath);
            if (!raw) throw new Error(APPLY_PATCH_MESSAGE);
            const before = tryParse(raw);
            if (!before) throw new Error(APPLY_PATCH_MESSAGE);

            const patched = applyPatch(raw, section.lines);
            if (!patched) throw new Error(APPLY_PATCH_MESSAGE);
            const after = tryParse(patched);
            if (!after) continue;

            guard(before, after);
          }

          if (section.action === "Delete") {
            const raw = await tryRead(absPath);
            if (!raw) continue;
            const before = tryParse(raw);
            if (before) guard(before, {});
          }
        }
      }
    },
  };
};
