-- install lazy.nvim if not already installed
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('config.options')
require('config.keymaps')

-- initialize lazy.nvim
require('lazy').setup('plugins', {
  defaults = {
    lazy = false,    -- all plugins are NOT lazy loaded by default (for now)
    version = false, -- use latest git commit
  },
  install = {
    missing = true,                 -- install missing plugins on startup
    colorscheme = { 'tokyonight', 'catppuccin' }, -- try to load colorscheme
  },
  checker = { enabled = true },
  ui = { border = 'rounded' },
})

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

--------------------------------------------------------------------------------
-- Diagnostics Keymaps

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic list' })
