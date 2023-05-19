--------------------------------------------------------------------------------
-- NeoVim Configuration



--------------------------------------------------------------------------------
-- Leader Key

-- must come before loading plugins
vim.g.mapleader = ' '
vim.g.localleader = ' '



--------------------------------------------------------------------------------
-- Install Package Manager

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)



--------------------------------------------------------------------------------
-- Configure Plugins

require('lazy').setup({
  'christoomey/vim-tmux-navigator',
}, {})



--------------------------------------------------------------------------------
-- Vim Options

local o = vim.opt

-- line numbers
o.number = true

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2
o.breakindent = true

-- mouse
o.mouse = 'a'

-- search
o.ignorecase = true
o.smartcase = true
o.hlsearch = false

-- undo
o.undofile = true

-- disable swapfile
o.swapfile = false

-- enable system clipboard
o.clipboard = 'unnamedplus'

-- keep sign column on by default
o.signcolumn = 'yes'

-- decrease update time
o.updatetime = 250
o.timeout = true
o.timeoutlen = 300

-- better completion experience
o.completeopt = 'menuone,noselect'

-- enable true color
o.termguicolors = true



--------------------------------------------------------------------------------
-- Keymaps

-- remove mapping of space (which is remapped to leader)
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- escape insert mode
vim.keymap.set('i', 'jk', '<ESC>', { desc = 'Escape insert mode'} )

-- easier file save
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', { desc = '[S]ave file'} )

-- clear search highlighting
vim.keymap.set('n', '<ESC>', '<cmd> noh <CR>', { desc = 'Clear search results highlights' })

-- handle word wrap when navigating up and down lines
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })



--------------------------------------------------------------------------------
-- Highlight on Yank

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

