return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'windwp/nvim-ts-autotag',
    },
    build = ':TSUpdate',
    opts = require('plugins.configs.treesitter').opts,
    config = require('plugins.configs.treesitter').config,
  },
}
