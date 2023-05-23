return {
  -- better navigation between neovim and tmux
  'christoomey/vim-tmux-navigator',

  -- detect tabwidth and tabstop automatically
  'tpope/vim-sleuth',

  -- show pending keybinds
  {
    'folke/which-key.nvim',
    opts = {},
  },

  -- set lualine as statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { { 'nvim-tree/nvim-web-devicons', opts = {} } },
    -- see: `:h lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = 'tokyonight',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  -- add indentation guides, even on blank lines
  {
    'lukas-reineke/indent-blankline.nvim',
    -- see `:h indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  -- toggle line and block comments
  {
    'numToStr/Comment.nvim',
    config = true,
  },
}
