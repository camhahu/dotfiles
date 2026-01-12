return {
    "Mofiqul/vscode.nvim",
    priority = 1000,
    config = function()
        require("vscode").setup({
            style = "dark",
            italic_comments = false,
        })
        vim.cmd.colorscheme("vscode")

        -- Neo-tree cursor line (more visible)
        vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#0078d4", fg = "#ffffff", bold = true })
    end,
}
