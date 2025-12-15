return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {
      indent = {
        char = '│', -- vertical line character
      },
      scope = {
        enabled = true, -- highlight current scope
        show_start = false,
        show_end = false,
      },
    },
  },
}
