local maps = {
  -- better up/down accounting for line wrap
  ['k'] = { "v:count == 0 ? 'gk' : 'k'", expr = true, desc = 'Move up a line' },
  ['j'] = { "v:count == 0 ? 'gj' : 'j'", expr = true, desc = 'Move down a line' },

  ['<leader>w'] = { '<cmd>w<cr>', desc = 'Save File' },
  ['<leader>q'] = { '<cmd>confirm q<cr>', desc = 'Quit' },
  ['<leader>n'] = { '<cmd>enew<cr>', desc = 'New File' },

  ['<C-s>'] = { '<cmd>w!<cr>', desc = 'Force write' },
  ['<C-q>'] = { '<cmd>q!<cr>', desc = 'Force quit' },

  -- splits
  ['|'] = { '<cmd>vsplit<cr>', desc = 'Vertical Split' },
  ['\\'] = { '<cmd>split<cr>', desc = 'Horizontal Split' },
}

for _, keymaps in ipairs({
  'core.keymaps.normal.plugin_manager',
  'core.keymaps.normal.mason',
  'core.keymaps.normal.buffers',
}) do
  local ok, keys = pcall(require, keymaps)
  if ok then
    maps = vim.tbl_extend('error', maps, keys)
  end
end

return maps
