local M = {}

M.opts = {
  highlight = {
    enable = true,
    disable = function(_, bufnr) return vim.api.nvim_buf_line_count(bufnr) > 10000 end,
  },
  incremental_selection = { enable = true },
  indent = { enable = true },
  autotag = { enable = true },
  context_commentstring = { enable = true, enable_autocmd = false },
}

M.config = function(_, opts) require('nvim-treesitter.configs').setup(opts) end

return M
