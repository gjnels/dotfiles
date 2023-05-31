local get_icon = require('utils').get_icon
return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = get_icon('GitSign') },
        change = { text = get_icon('GitSign') },
        delete = { text = get_icon('GitSign') },
        topdelete = { text = get_icon('GitSign') },
        changedelete = { text = get_icon('GitSign') },
        untracked = { text = get_icon('GitSign') },
      },
    },
  },
}
