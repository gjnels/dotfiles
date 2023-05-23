local utils = require('core.utils')

-- Remove default space mapping (space is set ot leader key)
utils.map({ 'n', 'v' }, '<Space>', '<Nop>')

-- Fetch all keymaps
local keymaps = {
  i = require('core.keymaps.insert'), -- insert mode
  n = require('core.keymaps.normal'), -- normal mode
  v = require('core.keymaps.visual'), -- visual/selection mode
  t = require('core.keymaps.terminal'), -- terminal mode
}

-- Set all keymaps
utils.set_mappings(keymaps)
