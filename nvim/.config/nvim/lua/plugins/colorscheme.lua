return {
    "Mofiqul/vscode.nvim",
    priority = 1000,
    config = function()
        require("vscode").setup({
            style = "dark",
            italic_comments = false,
        })
        vim.cmd.colorscheme("vscode")
    end,
}
