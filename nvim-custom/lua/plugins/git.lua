return {
  -- git plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      -- see `:h gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local function set(lhs, rhs, desc)
          vim.keymap.set('n', lhs, rhs, { buffer = bufnr, desc = desc })
        end
        local gs = require('gitsigns')

        set('[c', gs.prev_hunk, 'Go to Previous Hunk')
        set(']c', gs.next_hunk, 'Go to Next Hunk')
        set('<Leader>ph', gs.prev_hunk, '[P]review [H]unk')
      end,
    },
  },
}
