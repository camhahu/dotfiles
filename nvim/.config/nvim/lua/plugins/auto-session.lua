return {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
        suppressed_dirs = { "~/", "~/Downloads", "/" },
    },
    keys = {
        { "<leader>qs", "<cmd>AutoSession search<cr>", desc = "Search Sessions" },
        { "<leader>qd", "<cmd>AutoSession delete<cr>", desc = "Delete Session" },
    },
}
