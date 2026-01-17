import type { Plugin } from "@opencode-ai/plugin";

export const NotificationPlugin: Plugin = async ({ $ }) => {
  return {
    event: async ({ event }) => {
      if (event.type === "session.idle") {
        await $`afplay /System/Library/Sounds/Funk.aiff`;
      }
    },
    "tool.execute.before": async (input) => {
      if (input.tool === "question") {
        await $`afplay /System/Library/Sounds/Glass.aiff`;
      }
    },
  };
};
