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
                    highlight = "Directory",
                    separator = true,
                },
            },
            separator_style = "thin",
            show_buffer_close_buttons = false,
            show_close_icon = false,
        },
    },
}
