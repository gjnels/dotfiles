local M = {}

M.opts = {
  ui = {
    icons = {
      package_installed = '✓',
      package_uninstalled = '✗',
      package_pending = '⟳',
    },
  },
}

M.config = function(_, opts)
  require('mason').setup(opts)

  for _, plugin in ipairs({ 'mason-lspconfig', 'mason-null-ls', 'mason-nvim-dap' }) do
    pcall(require, plugin)
  end
end

return M
