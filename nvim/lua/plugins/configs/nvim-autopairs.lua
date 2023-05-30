local M = {}

M.opts = {
  check_ts = true,
  fast_wrap = {},
}

M.config = function(_, opts)
  local npairs = require('nvim-autopairs')
  npairs.setup(opts)

  if not vim.g.autopairs_enabled then npairs.disable() end
  local cmp_ok, cmp = pcall(require, 'cmp')
  if cmp_ok then cmp.event:on('confirm-done', require('nvim-autopairs.completion.cmp').on_confirm_done()) end
end

return M
