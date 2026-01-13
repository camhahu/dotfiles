return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("bufferline").setup({
            options = {
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Explorer",
                        text_align = "left",
                        highlight = "Directory",
                        separator = true,
                    },
                },
                themable = false,
                separator_style = "thin",
                show_buffer_close_icons = false,
                show_close_icon = false,
                indicator = {
                    style = "none",
                },
            },
            highlights = {
                buffer_selected = {
                    fg = "#ffffff",
                    bg = "#0078d4",
                    bold = true,
                    italic = false,
                },
                indicator_selected = {
                    fg = "#0078d4",
                    bg = "#0078d4",
                },
                indicator_visible = {
                    fg = "#1e1e1e",
                    bg = "#1e1e1e",
                },
                separator = {
                    fg = "#3e3e3e",
                    bg = "#1e1e1e",
                },
                separator_selected = {
                    fg = "#3e3e3e",
                    bg = "#0078d4",
                },
                separator_visible = {
                    fg = "#3e3e3e",
                    bg = "#1e1e1e",
                },
                background = {
                    fg = "#6e6e6e",
                    bg = "#1e1e1e",
                },
                fill = {
                    bg = "#1e1e1e",
                },
            },
        })
    end,
}
