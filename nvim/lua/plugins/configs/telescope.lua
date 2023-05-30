local M = {}

M.opts = function()
  local actions = require('telescope.actions')
  local mappings = {
    i = {
      ['<c-n>'] = actions.cycle_history_next,
      ['<c-p>'] = actions.cycle_history_prev,
      ['<c-j>'] = actions.move_selection_next,
      ['<c-k>'] = actions.move_selection_previous,
    },
    n = {
      ['q'] = actions.close,
    },
  }
  local get_icon = require('core.utils').get_icon
  return {
    defaults = {
      mappings = mappings,
      prompt_prefix = get_icon('Selected', 1),
      selection_caret = get_icon('Selected', 1),
      path_display = { 'truncate' },
      sorting_strategy = 'ascending',
      layout_config = {
        horizontal = {
          prompt_position = 'top',
          preview_width = 0.6,
        },
        vertical = {
          mirror = false,
        },
        width = 0.9,
        height = 0.8,
        preview_cutoff = 120,
      },
    },
  }
end

M.config = function(_, opts)
  local telescope = require('telescope')
  telescope.setup(opts)

  local utils = require('core.utils')

  if utils.has('telescope-fzf-native.nvim') then
    telescope.load_extension('fzf')
  end
end

return M
