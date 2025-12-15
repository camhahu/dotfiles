return {
    "Mofiqul/vscode.nvim",
    priority = 1000,
    config = function()
        require("vscode").setup({
            style = "dark",
            italic_comments = false,
        })
        vim.cmd.colorscheme("vscode")

        -- Tabline highlighting (mini.tabline)
        vim.api.nvim_set_hl(0, "MiniTablineCurrent", { fg = "#ffffff", bg = "#0078d4", bold = true })
        vim.api.nvim_set_hl(0, "MiniTablineVisible", { fg = "#cccccc", bg = "#333333" })
        vim.api.nvim_set_hl(0, "MiniTablineHidden", { fg = "#808080", bg = "#1e1e1e" })
        vim.api.nvim_set_hl(0, "MiniTablineModifiedCurrent", { fg = "#ffffff", bg = "#0078d4", bold = true })
        vim.api.nvim_set_hl(0, "MiniTablineModifiedVisible", { fg = "#cccccc", bg = "#333333" })
        vim.api.nvim_set_hl(0, "MiniTablineModifiedHidden", { fg = "#808080", bg = "#1e1e1e" })
        vim.api.nvim_set_hl(0, "MiniTablineFill", { bg = "#1e1e1e" })
    end,
}
