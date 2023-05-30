return {
  {
    'nvim-lua/plenary.nvim',
    lazy = true,
  },

  -- auto-pairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = require('plugins.configs.nvim-autopairs').opts,
    config = require('plugins.configs.nvim-autopairs').config,
  },

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = require('plugins.configs.which-key').opts,
    config = require('plugins.configs.which-key').config,
  },
}
