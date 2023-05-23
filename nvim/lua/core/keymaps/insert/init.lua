local maps = {
  -- Exit insert mode
  ['jk'] = { '<cmd>nohlsearch<cr><esc>', desc = 'Exit Insert and Clear Search Highlights' },

  -- Better <cr> functionality for insert mode with completion menu
  ['<cr>'] = {
    function()
      local popup_info = vim.fn.complete_info({ 'mode', 'selected' })
      if popup_info.mode ~= '' and popup_info.selected == -1 then
        return '<c-e><cr>'
      else
        return '<cr>'
      end
    end,
    expr = true,
  },
}

return maps
