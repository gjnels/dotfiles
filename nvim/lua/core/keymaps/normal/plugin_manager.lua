local sections = require('core.keymaps.sections')

local maps = {
  ['<leader>p'] = sections.p,
  ['<leader>pi'] = {
    function()
      require('lazy').install()
    end,
    desc = 'Install Plugins',
  },
  ['<leader>ps'] = {
    function()
      require('lazy').home()
    end,
    desc = 'Plugins Status',
  },
  ['<leader>pS'] = {
    function()
      require('lazy').sync()
    end,
    desc = 'Sync Plugins',
  },
  ['<leader>pu'] = {
    function()
      require('lazy').check()
    end,
    desc = 'Check for Plugin Updates',
  },
  ['<leader>pU'] = {
    function()
      require('lazy').update()
    end,
    desc = 'Update Plugins',
  },
  ['<leader>ph'] = {
    function()
      require('lazy').health()
    end,
    desc = 'Check lazy.nvim Health',
  },
}

return maps
