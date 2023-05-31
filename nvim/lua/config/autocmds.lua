local augroup = function(name, opts)
  opts = opts or {}
  vim.api.nvim_create_augroup(name, opts)
end
local autocmd = vim.api.nvim_create_autocmd
local utils = require('utils')

autocmd('TextYankPost', {
  desc = 'Highlight on yank',
  group = augroup('yank_highlight'),
  pattern = '*',
  callback = function() vim.highlight.on_yank() end,
})

autocmd('BufWinEnter', {
  desc = 'Make q close help, man, quickfix, dap floats',
  group = augroup('q_close_windows'),
  callback = function(event)
    local filetype = vim.api.nvim_get_option_value('filetype', { buf = event.buf })
    local buftype = vim.api.nvim_get_option_value('buftype', { buf = event.buf })
    if buftype == 'nofile' or filetype == 'help' then
      utils.map('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true, nowait = true })
    end
  end,
})

autocmd('BufWinEnter', {
  desc = 'Detect file indentation',
  group = augroup('indentation_settings'),
  callback = function(args)
    -- Run editor config
    require('editorconfig').config(args.buf)

    -- Run guess-indent (default to editorconfig)
    local gi_loaded, _ = pcall(require, 'guess-indent')
    if gi_loaded then vim.cmd.GuessIndent({
      args = { 'auto_cmd' },
      mods = { silent = true },
    }) end
  end,
})

autocmd('FileType', {
  desc = 'Restore cursor position',
  group = augroup('restore_cursor_position'),
  callback = function()
    local exclude = { diff = true, gitcommit = true, gitrebase = true }
    local position_line = vim.api.nvim_buf_get_mark(0, [["]])[1]
    if not exclude[vim.bo.filetype] and position_line >= 1 and position_line <= vim.api.nvim_buf_line_count(0) then
      vim.cmd.normal({
        bang = true,
        args = { [[g`"]] },
      })
    end
  end,
})

autocmd('CursorHold', {
  desc = 'Check if any buffers were changed outside of nvim on cursor hold',
  group = augroup('check_external_file_changes'),
  callback = function()
    vim.cmd.checktime({
      mods = { emsg_silent = true },
    })
  end,
})

autocmd('VimResized', {
  desc = 'Resize splits when vim is resized',
  group = augroup('check_window_resized'),
  callback = function()
    if vim.api.nvim_get_mode().mode ~= 'n' then
      vim.api.nvim_feedkeys(vim.api.nvim_eval([["\<c-\>\<c-n>"]]), 'n', false)
    end
    vim.api.nvim_feedkeys(vim.api.nvim_eval([["\<c-w>="]]), 'n', false)
  end,
})

autocmd('BufEnter', {
  desc = 'Quit Neovim if more than one window is open and only sidebar windows are list',
  group = augroup('auto_quit'),
  callback = function()
    local wins = vim.api.nvim_tabpage_list_wins(0)
    -- Both neo-tree and aerial will auto-quit if there is only a single window left
    if #wins <= 1 then return end
    local sidebar_fts = { aerial = true, ['neo-tree'] = true }
    for _, winid in ipairs(wins) do
      if vim.api.nvim_win_is_valid(winid) then
        local bufnr = vim.api.nvim_win_get_buf(winid)
        local filetype = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
        -- If any visible windows are not sidebars, early return
        if not sidebar_fts[filetype] then
          return
          -- If the visible window is a sidebar
        else
          -- only count filetypes once, so remove a found sidebar from the detection
          sidebar_fts[filetype] = nil
        end
      end
    end
    if #vim.api.nvim_list_tabpages() > 1 then
      vim.cmd.tabclose()
    else
      vim.cmd.qall()
    end
  end,
})

if utils.has('alpha-nvim') then
  local group_name = augroup('dashboard_settings')
  autocmd({ 'User', 'BufEnter' }, {
    desc = 'Disable status and tablines for alpha',
    group = group_name,
    callback = function(event)
      if
        (
          (event.event == 'User' and event.file == 'AlphaReady')
          or (event.event == 'BufEnter' and vim.api.nvim_get_option_value('filetype', { buf = event.buf }) == 'alpha')
        ) and not vim.g.before_alpha
      then
        vim.g.before_alpha = { showtabline = vim.opt.showtabline:get(), laststatus = vim.opt.laststatus:get() }
        vim.opt.showtabline, vim.opt.laststatus = 0, 0
      elseif
        vim.g.before_alpha
        and event.event == 'BufEnter'
        and vim.api.nvim_get_option_value('buftype', { buf = event.buf }) ~= 'nofile'
      then
        vim.opt.laststatus, vim.opt.showtabline = vim.g.before_alpha.laststatus, vim.g.before_alpha.showtabline
        vim.g.before_alpha = nil
      end
    end,
  })
  autocmd('VimEnter', {
    desc = 'Start Alpha when vim is opened with no arguments',
    group = group_name,
    callback = function()
      local should_skip = false
      if vim.fn.argc() > 0 or vim.fn.line2byte(vim.fn.line('$')) ~= -1 or not vim.o.modifiable then
        should_skip = true
      else
        for _, arg in pairs(vim.v.argv) do
          if arg == '-b' or arg == '-c' or vim.startswith(arg, '+') or arg == '-S' then
            should_skip = true
            break
          end
        end
      end
      if not should_skip then require('alpha').start(true, require('alpha').default_config) end
    end,
  })
end

if utils.has('neo-tree.nvim') then
  autocmd('BufEnter', {
    desc = 'Open Neo-Tree on startup with directory',
    group = augroup('neotree_start'),
    callback = function()
      if package.loaded['neo-tree'] then
        vim.api.nvim_del_augroup_by_name('neotree_start')
      else
        local stats = vim.loop.fs_stat(vim.api.nvim_buf_get_name(0))
        if stats and stats.type == 'directory' then
          vim.api.nvim_del_augroup_by_name('neotree_start')
          require('neo-tree')
        end
      end
    end,
  })
  autocmd('TermClose', {
    pattern = '*lazygit',
    desc = 'Refresh Neo-Tree git when closing lazygit',
    group = augroup('neotree_git_refresh'),
    callback = function()
      if package.loaded['neo-tree.sources.git_status'] then require('neo-tree.sources.git_status').refresh() end
    end,
  })
end

autocmd({ 'BufWritePre' }, {
  group = augroup('auto_create_dir'),
  desc = 'Create intermediate directories on save if they do not exist',
  callback = function(event)
    if event.match:match('^%w%w+://') then return end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})
