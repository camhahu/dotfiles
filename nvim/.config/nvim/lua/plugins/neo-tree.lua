return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    lazy = false,
    keys = {
        { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
        { "<leader>o", "<cmd>Neotree focus<cr>", desc = "Focus file explorer" },
    },
    opts = {
        close_if_last_window = true,
        enable_cursor_hijack = true, -- keep cursor on first letter of filename
        event_handlers = {
            {
                event = "neo_tree_buffer_enter",
                handler = function()
                    vim.opt_local.cursorline = true
                end,
            },
        },
        filesystem = {
            hijack_netrw_behavior = "disabled",
            follow_current_file = { enabled = true },
            use_libuv_file_watcher = true,
            filtered_items = {
                visible = true,
                hide_dotfiles = false,
                hide_gitignored = false,
            },
        },
        window = {
            width = 35,
            mappings = {
                ["<space>"] = "none", -- don't conflict with leader
            },
        },
        default_component_configs = {
            git_status = {
                symbols = {
                    added = "",
                    modified = "",
                    deleted = "",
                    renamed = "",
                    untracked = "",
                    ignored = "",
                    unstaged = "",
                    staged = "",
                    conflict = "",
                },
            },
        },
    },
}
