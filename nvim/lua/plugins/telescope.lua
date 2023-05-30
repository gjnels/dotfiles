return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        enabled = vim.fn.executable('make') == 1,
      },
    },
    cmd = 'Telescope',
    opts = require('plugins.configs.telescope').opts,
    config = require('plugins.configs.telescope').config,
  },
}
