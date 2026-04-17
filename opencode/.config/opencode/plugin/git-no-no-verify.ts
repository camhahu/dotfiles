import type { Plugin } from "@opencode-ai/plugin";

const BLOCKED_GIT_COMMIT =
  /^\s*(?:[A-Za-z_][A-Za-z0-9_]*=\S+\s+)*(?:env\s+)?(?:command\s+|builtin\s+)?(?:\S*\/)?git\b.*\bcommit\b.*(?:^|\s)--no-verify(?:\s|$)/;

const MESSAGE = [
  "Blocking `git commit --no-verify`.",
  "We don't skip commit hooks. Those checks are in place to protect the repo.",
  "Fix the hook failures correctly instead.",
].join("\n");

function shouldBlock(command: string): boolean {
  return command.split(/(?:&&|\|\||;|&)/).some((segment) => BLOCKED_GIT_COMMIT.test(segment));
}

export const GitNoNoVerifyPlugin: Plugin = async () => {
  return {
    "tool.execute.before": async (input, output) => {
      if (input.tool !== "bash") return;
      if (typeof output.args.command !== "string") return;
      if (!shouldBlock(output.args.command)) return;

      throw new Error(MESSAGE);
    },
  };
};
