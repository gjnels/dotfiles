--------------------------------------------------------------------------------
-- NeoVim Configuration



--------------------------------------------------------------------------------
-- Leader Key

-- must come before loading plugins
vim.g.mapleader = ' '
vim.g.localleader = ' '



--------------------------------------------------------------------------------
-- Install Package Manager

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)



--------------------------------------------------------------------------------
-- Configure Plugins

require('lazy').setup({
  -- better navigation between neovim and tmux
  'christoomey/vim-tmux-navigator',

  -- git plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- detect tabwidth and tabstop automatically
  'tpope/vim-sleuth',

  -- LSP configuration and plugins
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true, build = ':MasonUpdate' },
      'williamboman/mason-lspconfig.nvim',

      -- status updates for LSP
      {
        'j-hui/fidget.nvim',
        opts = {},
      },

      -- additional lua configuration
      'folke/neodev.nvim',
    },
  },

  -- autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
    },
  },

  -- show pending keybinds
  {
    'folke/which-key.nvim',
    opts = {},
  },

  -- adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      -- see `:h gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '[c', require('gitsigns').prev_hunk, { buffer = bufnr, desc = 'Go to Previous Hunk' })
        vim.keymap.set('n', ']c', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'Go to Next Hunk' })
        vim.keymap.set('n', '<Leader>ph', require('gitsigns').prev_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end
    },
  },

  -- catppuccin theme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
  },

  -- set lualine as statusline
  {
    'nvim-lualine/lualine.nvim',
    -- see: `:h lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = 'catppuccin',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  -- add indentation guides, even on blank lines
  {
    'lukas-reineke/indent-blankline.nvim',
    -- see `:h indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  -- toggle line and block comments
  {
    'numToStr/Comment.nvim',
    opts = {},
  },

  -- fuzzy finder (files, LSP, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- fuzzy finder algorithm which requires local dependencies to be built
  -- requires 'make' to be installed, don't load if 'make' is not installed
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  -- highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- TODO: move plugins to lua/custom/plugins or lua/plugins
  -- { import = 'customs.plugins' }
  -- { import = 'plugins' }

}, {})



--------------------------------------------------------------------------------
-- Vim Options

local o = vim.opt

-- line numbers
o.number = true
o.relativenumber = true

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2
o.breakindent = true

-- mouse
o.mouse = 'a'

-- search
o.ignorecase = true
o.smartcase = true
o.hlsearch = false

-- undo
o.undofile = true

-- disable swapfile
o.swapfile = false

-- enable system clipboard
o.clipboard = 'unnamedplus'

-- keep sign column on by default
o.signcolumn = 'yes'

-- decrease update time
o.updatetime = 250
o.timeout = true
o.timeoutlen = 300

-- better completion experience
o.completeopt = 'menuone,noselect'

-- enable true color
o.termguicolors = true

-- enable catppuccin colorscheme
vim.cmd.colorscheme 'catppuccin'



--------------------------------------------------------------------------------
-- Keymaps

-- remove mapping of space (which is remapped to leader)
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- escape insert mode
vim.keymap.set('i', 'jk', '<ESC>', { desc = 'Escape insert mode' })

-- easier file save
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', { desc = '[S]ave file' })

-- clear search highlighting
vim.keymap.set('n', '<ESC>', '<cmd> noh <CR>', { desc = 'Clear search results highlights' })

-- handle word wrap when navigating up and down lines
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })



--------------------------------------------------------------------------------
-- Highlight on Yank

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})



--------------------------------------------------------------------------------
-- Configure Telescope

-- see: `:h telescope` or `:h telescope.setup()`

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- telescope keybindings
-- see `:h telescope.builtin`
vim.keymap.set('n', '<Leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<Leader><Space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<Leader>/', function()
  -- optionally pass additional configuration to telescope to change theme, layout, etc
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    windblend = 10,
    previewer = true,
  })
end, { desc = '[ ] Find recently opened files' })
vim.keymap.set('n', '<Leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<Leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<Leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<Leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<Leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<Leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })



--------------------------------------------------------------------------------
-- Configure Treesitter

-- see: `:h nvim-treesitter`

require('nvim-treesitter.configs').setup {
  -- languages always installed
  ensure_installed = { 'go', 'html', 'javascript', 'json', 'json5', 'jsonc', 'lua', 'svelte', 'tsx', 'typescript',
    'vimdoc', 'vim' },

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<C-Space>',
      node_incremental = 'C-Space>',
      scope_incremental = '<C-s>',
      node_decremental = '<M-Space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- automatically jump forward to textobject, similar to targets.vim
      keymaps = {
        -- use capture groups defined in textobjects.scm
        ['aa'] = '@paramter.outer', -- [a]round argument
        ['ia'] = '@paramter.inner', -- [i]nside argument
        ['af'] = '@function.outer', -- [a]round [f]unction
        ['if'] = '@function.inner', -- [i]nside [f]unction
        ['ac'] = '@class.outer',    -- [a]round [c]lass
        ['ic'] = '@class.inner',    -- [i]nside [c]lass
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- set jumps in jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<Leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<Leader>A'] = '@parameter.inner',
      },
    },
  },
}



--------------------------------------------------------------------------------
-- Diagnostics Keymaps

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic list' })



--------------------------------------------------------------------------------
-- LSP Settings

-- This function is run when an LSP connects to a particular buffer
local on_attach = function(_, bufnr)
  -- helper function to set LSP specific mappings
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<Leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<Leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<Leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<Leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<Leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- see: `:h K` for why this keymap is included
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-S-Space>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- create command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
  vim.keymap.set('n', '<Leader>fd', ':Format <CR>', { silent = true, desc = '[F]ormat [D]ocument' })
end

-- setup neovim lua configuration
require('neodev').setup()

-- mason config
require('mason').setup({
  ui = {
    border = 'rounded',
    icons = {
      package_installed = '',
      package_pending = '󰇘',
      package_uninstalled = '',
    },
  },
})

-- language servers to enable by default
local servers = {
  gopls = {},
  tsserver = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- broadcast additional completion capabilities from nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- ensure servers listed above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}



--------------------------------------------------------------------------------
-- nvim-cmp Setup

local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpback() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_previous_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
