local nls = require('null-ls')

local formatting = nls.builtins.formatting

local sources = {
  formatting.prettierd,
  formatting.stylua,
  formatting.beautysh,
}

nls.setup({
  debug = true,
  sources = sources,
})
