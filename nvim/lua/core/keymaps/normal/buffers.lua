local maps = {
  ['<leader>b'] = require('core.keymaps.sections').b,

  -- switch buffers
  ['<leader>bn'] = { '<cmd>bnext<cr>', desc = 'Go to Next Buffer' },
  ['<leader>bp'] = { '<cmd>bprevious<cr>', desc = 'Go to Previous Buffer' },
}

return maps
