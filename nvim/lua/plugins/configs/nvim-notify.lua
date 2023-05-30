local M = {}

M.config = function(_, opts)
  local notify = require('notify')
  notify.setup(opts)
  -- Use nvim-notify for vim notifications
  vim.notify = notify
end

return M
