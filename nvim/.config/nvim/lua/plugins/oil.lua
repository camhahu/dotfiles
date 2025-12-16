return {
    "stevearc/oil.nvim",
    opts = {
        win_options = { signcolumn = "yes:2" },
        view_options = { show_hidden = true },
        prompt_save_on_select_new_entry = true,
        float = {
            padding = 2,
            max_width = 0.6,
            max_height = 0.7,
            border = "rounded",
        },
    },
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    lazy = false,
}
