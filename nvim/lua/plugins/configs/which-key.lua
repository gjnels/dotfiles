local M = {}

M.opts = {
  icons = { group = vim.g.icons_enabled and '' or '+', separator = '' },
  disable = { filetypes = { 'TelescopePrompt' } },
}

M.config = function(_, opts)
  require('which-key').setup(opts)
  require('core.utils').which_key_register()
end

return M
