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

  {
    'numToStr/Comment.nvim',
    keys = {
      { 'gc', mode = { 'n', 'v' }, desc = 'Comment toggle linewise' },
      { 'gb', mode = { 'n', 'v' }, desc = 'Comment toggle blockwise' },
    },
    opts = function()
      local commentstring_ok, commentstring = pcall(require, 'ts_context_commentstring.integrations.comment_nvim')
      return commentstring_ok and commentstring and { pre_hook = commentstring.create_pre_hook() } or {}
    end,
  },
}
