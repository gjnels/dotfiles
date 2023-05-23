local get_icon = require('core.utils').get_icon
return {
  f = { desc = get_icon('Search', 1) .. 'Find' },
  p = { desc = get_icon('Package', 1) .. 'Packages' },
  m = { desc = get_icon('Mason', 1) .. 'Mason' },
  l = { desc = get_icon('ActiveLSP', 1) .. 'LSP' },
  u = { desc = get_icon('Window', 1) .. 'UI' },
  b = { desc = get_icon('Tab', 1) .. 'Buffers' },
  bs = { desc = get_icon('Sort', 1) .. 'Sort Buffers' },
  d = { desc = get_icon('Debugger', 1) .. 'Debugger' },
  g = { desc = get_icon('Git', 1) .. 'Git' },
  S = { desc = get_icon('Session', 1) .. 'Session' },
  t = { desc = get_icon('Terminal', 1) .. 'Terminal' },
}
