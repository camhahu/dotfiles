return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
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
            separator_style = "slant",
            show_buffer_close_buttons = false,
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
            separator = {
                fg = "#1e1e1e",
                bg = "#1e1e1e",
            },
            separator_selected = {
                fg = "#1e1e1e",
            },
            separator_visible = {
                fg = "#1e1e1e",
            },
            background = {
                fg = "#6e6e6e",
                bg = "#1e1e1e",
            },
            fill = {
                bg = "#1e1e1e",
            },
        },
    },
}
