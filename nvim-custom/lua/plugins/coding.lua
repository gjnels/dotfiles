return {
  {
    'echasnovski/mini.pairs',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },

  {
    'echasnovski/mini.surround',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },

  -- detect tabwidth and tabstop automatically
  {
    'tpope/vim-sleuth',
    event = { 'BufReadPre', 'BufNewFile' },
  },

  -- add indentation guides, even on blank lines
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    -- see `:h indent_blankline.txt`
    opts = {
      char = '┊',
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
  },

  -- toggle line and block comments
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },
}
