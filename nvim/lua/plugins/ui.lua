return {
  {
    'rcarriga/nvim-notify',
    init = function() require('core.utils').load_plugin_with_func('nvim-notify', vim, 'notify') end,
    opts = {
      on_open = function(win) vim.api.nvim_win_set_config(win, { zindex = 1000 }) end,
    },
    config = require('plugins.configs.nvim-notify').config
  },
}
