return {
  {
    'williamboman/mason.nvim',
    cmd = {
      'Mason',
      'MasonInstall',
      'MasonUninstall',
      'MasonUninstallAll',
      'MasonLog',
    },
    build = ':MasonUpdate',
    opts = require('plugins.configs.mason').opts,
    config = require('plugins.configs.mason').config,
  },
}
