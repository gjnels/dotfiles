return function(_, opts)
  local telescope = require('telescope')
  telescope.setup(opts)

  local utils = require('core.utils')

  if utils.has('telescope-fzf-native.nvim') then
    telescope.load_extension('fzf')
  end
end
