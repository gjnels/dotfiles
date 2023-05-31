local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  -- Clone lazy.nvim
  local output = vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
  -- Check for lazy.nvim cloning error
  if vim.api.nvim_get_vvar('shell_error') ~= 0 then
    vim.api.nvim_err_writeln('Error cloning lazy.nvim repo...\n\n' .. output)
  end

  -- Load Mason and Treesitter after lazy installs plugins

  -- temporarily show command line
  local oldcmdheight = vim.opt.cmdheight:get()
  vim.opt.cmdheight = 1

  vim.notify('Plugins are installing...')

  vim.api.nvim_create_autocmd('User', {
    desc = 'Load Mason and Treesitter after Lazy intalls plugins',
    once = true, -- only run autocmd one time
    pattern = 'LazyInstall', -- after Lazy installs plugins
    callback = function()
      vim.cmd.bw() -- wipe all buffers
      vim.opt.cmdheight = oldcmdheight -- reset cmdheight
      -- Load Mason and Treesitter
      vim.tbl_map(function(module)
        pcall(require, module)
      end, { 'nvim-treesitter', 'mason' })
      -- Notify Mason installing packages
      vim.schedule(function()
        vim.notify('Mason is installing preconfigured packages, check status with :Mason')
      end)
    end,
  })
end
vim.opt.rtp:prepend(lazypath)

local spec = {
  { import = 'plugins' },
}

local colorscheme = { 'tokyonight' }

require('lazy').setup({
  spec = spec,
  defaults = { lazy = false },
  install = { colorscheme = colorscheme },
  ui = {
    border = 'rounded',
  },
  performance = {
    disabled_plugins = { 'tohtml', 'gzip', 'zipPlugin', 'netrwPlugin', 'tarPlugin', 'tutor' },
  },
})
