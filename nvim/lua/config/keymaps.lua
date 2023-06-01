local utils = require('utils')

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

keymaps.n['<leader>w'] = { '<cmd>w<cr>', desc = 'Save file' }
keymaps.n['<leader>q'] = { '<cmd>confirm q<cr>', desc = 'Quit' }
keymaps.n['<leader>n'] = { '<cmd>enew<cr>', desc = 'New file' }
keymaps.n['<C-s>'] = { '<cmd>w!<cr>', desc = 'Force write' }
keymaps.n['<C-q>'] = { '<cmd>q!<cr>', desc = 'Force quit' }

-- better up/down accounting for line wrap
keymaps.n['k'] = { "v:count == 0 ? 'gk' : 'k'", expr = true, desc = 'Move up a line' }
keymaps.n['j'] = { "v:count == 0 ? 'gj' : 'j'", expr = true, desc = 'Move down a line' }

-- splits
keymaps.n['|'] = { '<cmd>vsplit<cr>', desc = 'Vertical split' }
keymaps.n['\\'] = { '<cmd>split<cr>', desc = 'Horizontal split' }

keymaps.n['<esc>'] = { '<cmd>nohlsearch<cr>', desc = 'Clear search highlights' }

-- Plugin manager
local lazy = require('lazy')
keymaps.n['<leader>p'] = sections.p
keymaps.n['<leader>pi'] = { function() lazy.install() end, desc = 'Install plugins' }
keymaps.n['<leader>ps'] = { function() lazy.home() end, desc = 'Plugins status' }
keymaps.n['<leader>pS'] = { function() lazy.sync() end, desc = 'Sync plugins' }
keymaps.n['<leader>pu'] = { function() lazy.check() end, desc = 'Check for plugin updates' }
keymaps.n['<leader>pU'] = { function() lazy.update() end, desc = 'Update plugins' }
keymaps.n['<leader>ph'] = { function() lazy.health() end, desc = 'Check lazy.nvim health' }

-- Mason.nvim
if utils.has('mason') then
  keymaps.n['<leader>pm'] = { '<cmd>Mason<cr>', desc = 'Open Mason' }
  keymaps.n['<leader>pM'] = { '<cmd>Mason<cr>U', desc = 'Update Mason packages' }
end

-- Buffers
keymaps.n['<leader>b'] = sections.b
keymaps.n['<leader>bn'] = { '<cmd>bnext<cr>', desc = 'Go to next buffer' }
keymaps.n['<leader>bp'] = { '<cmd>bprevious<cr>', desc = 'Go to previous buffer' }
keymaps.n['<leader>bd'] = { '<cmd>bdelete<cr>', desc = 'Delete current buffer' }

-- Telescope
if utils.has('telescope.nvim') then
  keymaps.n['<leader>f'] = sections.f
  keymaps.n['<leader>g'] = sections.g

  local builtin = require('telescope.builtin')

  keymaps.n['<leader>gb'] = { function() builtin.git_branches() end, desc = 'Git branches' }
  keymaps.n['<leader>gc'] = { function() builtin.git_commits() end, desc = 'Git commits' }
  keymaps.n['<leader>gs'] = { function() builtin.git_status() end, desc = 'Git status' }
  keymaps.n['<leader>f<cr>'] = { function() builtin.resume() end, desc = 'Resume previous search' }
  keymaps.n["<leader>f'"] = { function() builtin.marks() end, desc = 'Find marks' }
  keymaps.n['<leader>fb'] = { function() builtin.buffers() end, desc = 'Find buffers' }
  keymaps.n['<leader>fc'] = { function() builtin.grep_string() end, desc = 'Find word under cursor' }
  keymaps.n['<leader>fC'] = { function() builtin.commands() end, desc = 'Find commands' }
  keymaps.n['<leader>ff'] = { function() builtin.find_files() end, desc = 'Find files' }
  keymaps.n['<leader>fF'] =
    { function() builtin.find_files({ hidden = true, no_ignore = true }) end, desc = 'Find all files' }
  keymaps.n['<leader>fh'] = { function() builtin.help_tags() end, desc = 'Find help' }
  keymaps.n['<leader>fi'] = { function() builtin.current_buffer_fuzzy_find() end, desc = 'Find in current buffer' }
  keymaps.n['<leader>fk'] = { function() builtin.keymaps() end, desc = 'Find keymaps' }
  keymaps.n['<leader>fm'] = { function() builtin.man_pages() end, desc = 'Find man pages' }
  if utils.has('nvim-notify') then
    keymaps.n['<leader>fn'] =
      { function() require('telescope').extensions.notify.notify() end, desc = 'Find notifications' }
  end
  keymaps.n['<leader>fr'] = { function() builtin.oldfiles() end, desc = 'Find recent files' }
  keymaps.n['<leader>fR'] = { function() builtin.registers() end, desc = 'Find registers' }
  keymaps.n['<leader>ft'] = { function() builtin.colorscheme({ enable_preview = true }) end, desc = 'Find themes' }
  keymaps.n['<leader>fw'] = { function() builtin.live_grep() end, desc = 'Find words' }
  keymaps.n['<leader>fW'] = {
    function()
      builtin.live_grep({
        additional_args = function(args) return vim.list_extend(args, { '--hidden', '--no-ignore' }) end,
      })
    end,
    desc = 'Find words in all files',
  }

  -- lsp
  keymaps.n['<leader>l'] = sections.l
  keymaps.n['<leader>lD'] = { function() builtin.diagnostics() end, desc = 'Search diagnostics' }
  keymaps.n['<leader>ls'] = {
    function()
      if utils.has('aerial.nvim') then
        require('telescope').extensions.aerial.aerial()
      else
        builtin.lsp_document_symbols()
      end
    end,
    desc = 'Search symbols',
  }
end

-- Insert Mode --

-- Exit insert mode
keymaps.i['jk'] = { '<esc>', desc = 'Exit insert mode' }

-- Better enter key behavior with completion
keymaps.i['<cr>'] = {
  function()
    local popup_info = vim.fn.complete_info({ 'mode', 'selected' })
    if popup_info.mode ~= '' and popup_info.selected == -1 then
      return '<c-e><cr>'
    else
      return '<cr>'
    end
  end,
  silent = true,
}

-- Set all keymaps
utils.set_mappings(keymaps)
