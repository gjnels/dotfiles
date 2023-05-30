local utils = require('core.utils')

-- Remove default space mapping (space is set to leader key)
utils.map({ 'n', 'v' }, '<Space>', '<Nop>')

local get_icon = utils.get_icon
local sections = {
  f = { desc = get_icon('Search', 1) .. 'Find' },
  p = { desc = get_icon('Package', 1) .. 'Packages' },
  l = { desc = get_icon('ActiveLSP', 1) .. 'LSP' },
  u = { desc = get_icon('Window', 1) .. 'UI' },
  b = { desc = get_icon('Tab', 1) .. 'Buffers' },
  bs = { desc = get_icon('Sort', 1) .. 'Sort Buffers' },
  d = { desc = get_icon('Debugger', 1) .. 'Debugger' },
  g = { desc = get_icon('Git', 1) .. 'Git' },
  S = { desc = get_icon('Session', 1) .. 'Session' },
  t = { desc = get_icon('Terminal', 1) .. 'Terminal' },
}

local keymaps = {
  i = {}, -- insert mode
  n = {}, -- normal mode
  v = {}, -- visual/selection mode
  t = {}, -- terminal mode
}

-- Normal Mode --

keymaps.n['<leader>w'] = { '<cmd>w<cr>', desc = 'Save File' }
keymaps.n['<leader>q'] = { '<cmd>confirm q<cr>', desc = 'Quit' }
keymaps.n['<leader>n'] = { '<cmd>enew<cr>', desc = 'New File' }
keymaps.n['<C-s>'] = { '<cmd>w!<cr>', desc = 'Force Write' }
keymaps.n['<C-q>'] = { '<cmd>q!<cr>', desc = 'Force Quit' }

-- better up/down accounting for line wrap
keymaps.n['k'] = { "v:count == 0 ? 'gk' : 'k'", expr = true, desc = 'Move Up a Line' }
keymaps.n['j'] = { "v:count == 0 ? 'gj' : 'j'", expr = true, desc = 'Move Down a Line' }

-- splits
keymaps.n['|'] = { '<cmd>vsplit<cr>', desc = 'Vertical Split' }
keymaps.n['\\'] = { '<cmd>split<cr>', desc = 'Horizontal Split' }

keymaps.n['<esc>'] = { '<cmd>nohlsearch<cr>', desc = 'Clear Search Highlights' }

-- Plugin manager
local lazy = require('lazy')
keymaps.n['<leader>p'] = sections.p
keymaps.n['<leader>pi'] = { function() lazy.install() end, desc = 'Install Plugins' }
keymaps.n['<leader>ps'] = { function() lazy.home() end, desc = 'Plugins Status' }
keymaps.n['<leader>pS'] = { function() lazy.sync() end, desc = 'Sync Plugins' }
keymaps.n['<leader>pu'] = { function() lazy.check() end, desc = 'Check for Plugin Updates' }
keymaps.n['<leader>pU'] = { function() lazy.update() end, desc = 'Update Plugins' }
keymaps.n['<leader>ph'] = { function() lazy.health() end, desc = 'Check lazy.nvim Health' }

-- Mason.nvim
if utils.has('mason') then
  keymaps.n['<leader>pm'] = { '<cmd>Mason<cr>', desc = 'Open Mason' }
  keymaps.n['<leader>pM'] = { '<cmd>Mason<cr>U', desc = 'Update Mason Packages' }
end

-- Buffers
keymaps.n['<leader>b'] = sections.b
keymaps.n['<leader>bn'] = { '<cmd>bnext<cr>', desc = 'Go to Next Buffer' }
keymaps.n['<leader>bp'] = { '<cmd>bprevious<cr>', desc = 'Go to Previous Buffer' }
keymaps.n['<leader>bd'] = { '<cmd>bdelete<cr>', desc = 'Delete Current Buffer' }

-- Insert Mode --

-- Exit insert mode
keymaps.i['jk'] = { '<esc>', desc = 'Exit Insert Mode' }

-- Better <cr> functionality for insert mode with completion menu
keymaps.i['<cr>'] = {
  function()
    local popup_info = vim.fn.complete_info({ 'mode', 'selected' })
    if popup_info.mode ~= '' and popup_info.selected == -1 then
      return '<c-e><cr>'
    else
      return '<cr>'
    end
  end,
  expr = true,
}

-- Set all keymaps
utils.set_mappings(keymaps)
