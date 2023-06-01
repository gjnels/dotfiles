vim.opt.viewoptions:remove('curdir') -- disable saving current directory with views
vim.opt.shortmess:append({ s = true, I = true }) -- disable startup messages
vim.opt.backspace:append({ 'nostop' }) -- don't stop backspace at insert
vim.opt.diffopt:append('linematch:60') -- enable linematch diff algorithm

local options = {
  opt = {
    mouse = 'a', -- enable mouse support
    clipboard = 'unnamedplus', -- connect to system clipboard
    termguicolors = true, -- enable true color
    undofile = true, -- enable persistent undo
    pumheight = 10, -- size of popup menus
    signcolumn = 'yes', -- always show sign column
    fillchars = { eob = ' ' }, -- disable '~' on non-existent lines
    cursorline = true, -- Highlight the text line of the cursor
    fileencoding = 'utf-8', -- File content encoding for the buffer
    infercase = true, -- Infer cases in keyword completion
    history = 100, -- Number of commands to remember in a history table
    virtualedit = 'block', -- allow going past end of line in visual block mode
    writebackup = false, -- Disable making a backup before overwriting a file

    -- Insert mode completion options
    -- see :h completeopt
    completeopt = { 'menu', 'menuone', 'noselect', 'preview' },

    -- Timeout
    timeout = true, -- enable timeout
    timeoutlen = 300, -- key timeout length
    updatetime = 300, -- length of time to wait before triggering a plugin

    -- Statusline
    cmdheight = 0, -- hide command line unless needed
    laststatus = 3, -- global status
    showmode = false, -- disable showing modes in command line
    showtabline = 2, -- always display tabline

    -- Searching
    hlsearch = true, -- highlight search results
    ignorecase = true, -- case insensitive searching
    smartcase = true, -- case sensitive search with /C or capital in search

    -- Indentation
    breakindent = true, -- wrap indent to match line start
    linebreak = true, -- wrap lines at 'breakat' (see :h breakat)
    copyindent = true, -- copy previous indentation on autoformatting
    preserveindent = true, -- preserve indent structure as much as possible
    smartindent = true, -- smarter autoindentation
    expandtab = true, -- use spaces instead of tabs
    shiftwidth = 0, -- default to tabstop value
    softtabstop = -1, -- default to tabstop value
    tabstop = 2, -- number of spaces in a tab
    wrap = true, -- enable wrapping of lines longer than window width

    -- Line numbers
    number = true, -- show line numbers
    relativenumber = true, -- show relative line numbers

    -- Code folding
    foldenable = true, -- enable fold for nvim-ufo
    foldlevel = 99, -- set high foldlevel for nvim-ufo
    foldlevelstart = 99, -- start with all code unfolded
    foldcolumn = vim.fn.has('nvim-0.9') == 1 and '1' or nil, -- show foldcolumn in nvim 0.9

    -- Windows
    scrolloff = 8, -- Number of lines to keep above and below the cursor
    sidescrolloff = 8, -- Number of columns to keep at the sides of the cursor
    splitbelow = true, -- Splitting a new window below the current one
    splitright = true, -- Splitting a new window at the right of the current one
  },
  -- global options
  g = {
    mapleader = ' ', -- set leader key
    autopairs_enabled = true, -- enable autopairs at start
    autoformat_enabled = true, -- enable autoformatting at start
    highlighturl_enabled = true, -- highlight URLs by default
    codelens_enabled = true, -- enable or disable automatic codelens refreshing for lsp that support it
    lsp_handlers_enabled = true, -- enable or disable default vim.lsp.handlers (hover and signatureHelp)
    cmp_enabled = true, -- enable completion at start
    diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
    icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available)
    ui_notifications_enabled = true, -- disable notifications when toggling UI elements
    editorconfig = false, -- don't run editor config automatically
  },
}

-- Apply all options
for scope, table in pairs(options) do
  for setting, value in pairs(table) do
    vim[scope][setting] = value
  end
end
