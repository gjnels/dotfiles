-- This file is loaded before plugins

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- remove mapping of space (which is remapped to leader)
map({ 'n', 'v' }, '<space>', '<nop>', { silent = true })

-- escape insert mode
map('i', 'jk', '<esc>', { desc = 'Escape insert mode' })

-- quit neovim completely
map({ 'n', 'v', 's' }, '<c-q>', '<cmd>qa!<cr>', { desc = 'Quit Neovim' })

-- easier file save
map({ 'n', 'v', 'i', 's' }, '<c-s>', '<cmd>w<cr><esc>', { desc = '[S]ave file' })

-- clear search highlighting
map({'n', 'i'}, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Clear search results highlights' })

-- handle word wrap when navigating up and down lines
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- move to windows using <ctrl> and hjkl
map('n', '<c-h>', '<c-w>h', { desc = 'Go to left window' })
map('n', '<c-j>', '<c-w>j', { desc = 'Go to upper window' })
map('n', '<c-k>', '<c-w>k', { desc = 'Go to lower window' })
map('n', '<c-l>', '<c-w>l', { desc = 'Go to right window' })

-- resize windows using <ctrl> and arrow keys
map('n', '<c-up>', '<cmd>resize +2<cr>', { desc = 'Increase window height'})
map('n', '<c-down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height'})
map('n', '<c-right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width'})
map('n', '<c-left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width'})

-- Move lines
map('n', '<a-j>', '<cmd>m .+1<cr>==', { desc = 'Move line down' })
map('n', '<a-k>', '<cmd>m .-2<cr>==', { desc = 'Move line up' })
map('i', '<a-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move line down' })
map('i', '<a-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move line up' })
map('v', '<a-j>', ":m '>+1<cr>gv=gv", { desc = 'Move line down' })
map('v', '<a-k>', ":m '>-2<cr>gv=gv", { desc = 'Move line up' })

-- buffers
if require('lazy.core.config').plugins['bufferline.nvim'] ~= nil then
  map('n', '<s-h>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Previous buffer' })
  map('n', '<s-l>', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next buffer' })
  map('n', '[b', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Previous buffer' })
  map('n', ']b', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next buffer' })
else
  map('n', '<s-h>', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })
  map('n', '<s-l>', '<cmd>bnext<cr>', { desc = 'Next buffer' })
  map('n', '[b', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })
  map('n', ']b', '<cmd>bnext<cr>', { desc = 'Next buffer' })
end
