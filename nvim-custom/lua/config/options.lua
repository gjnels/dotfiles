-- This file is loaded before any plugins

vim.g.mapleader = ' '
vim.g.localleader = ' '

-- line numbers
vim.wo.number = true
vim.wo.relativenumber = true

local o = vim.opt

-- indenting
o.expandtab = true
o.shiftwidth = 2
o.shiftround = true
o.smartindent = true
o.tabstop = 2
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

-- show horizontal cursor line
o.cursorline = true

-- hide concealed text
o.conceallevel = 3

-- lines visible above and below cursor
o.scrolloff = 10

-- hide mode since using statusline
o.showmode = false

-- put new windows below current
o.splitbelow = true
-- put new windows to the right of current
o.splitright = true

-- use ripgrep for grep
o.grepprg = 'rg --vimgrep'
