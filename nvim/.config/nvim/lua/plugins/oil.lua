return {
    "stevearc/oil.nvim",
    opts = {
        win_options = { signcolumn = "yes:2" },
        view_options = { show_hidden = true },
        prompt_save_on_select_new_entry = true,
    },
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    lazy = false,
}
