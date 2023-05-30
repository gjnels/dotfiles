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
}
