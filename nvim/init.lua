--------------------------------------------------------------------------------
-- NeoVim Configuration



--------------------------------------------------------------------------------
-- Vim Options

-- leader key
vim.g.mapleader = ' '
vim.g.localleader = ' '

local opt = vim.opt

-- line numbers
opt.number = true
opt.relativenumber = true

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

-- mouse
opt.mouse = 'a'

-- search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- undo
opt.undofile = true

-- disable swapfile
opt.swapfile = false

-- enable system clipboard
opt.clipboard = 'unnamedplus'



--------------------------------------------------------------------------------
-- Keymaps

-- escape insert mode
vim.keymap.set('i', 'jk', '<ESC>', {desc = 'Escape insert mode'})

-- easier file save
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', {desc = '[S]ave file'})

-- clear search highlighting
vim.keymap.set('n', '<ESC>', '<cmd> noh <CR>', {desc = 'Clear search results highlights'})
