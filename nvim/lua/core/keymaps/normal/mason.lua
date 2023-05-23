local sections = require('core.keymaps.sections')

if not require('core.utils').has('mason.nvim') then
  return {}
end

local maps = {
  ['<leader>m'] = sections.m,
  ['<leader>ma'] = {'<cmd>Mason<cr>', desc = 'Open Mason'},
  ['<leader>ml'] = {'<cmd>Mason<cr>2', desc = 'Open Mason Languages'},
}

return maps
