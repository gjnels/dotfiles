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

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- additional lua configuration
      { 'folke/neodev.nvim', opts = {} },
      { 'folke/neoconf.nvim', cmd = 'Neoconf', config = true },
      'mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',

      -- status updates for LSP
      {
        'j-hui/fidget.nvim',
        opts = {},
      },
    },
    opts = {
      servers = {
        bashls = {},
        gopls = {},
        tsserver = {},
        jsonls = {},
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      },
    },
    config = function(_, opts)
      local mlsp = require('mason-lspconfig')
      mlsp.setup({ ensure_installed = vim.tbl_keys(opts.servers) })
      mlsp.setup_handlers({
        function(server_name)
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
          require('lspconfig')[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = opts.servers[server_name],
          })
        end,
      })
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'mason.nvim' },
    opts = function()
      local nls = require('null-ls')
      return {
        root_dir = require('null-ls.utils').root_pattern('.null-ls-root', '.neoconf.json', 'Makefile', '.git'),
        sources = {
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.prettierd,
        },
      }
    end,
  },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
    build = ':MasonUpdate',
    opts = {
      ui = {
        border = 'rounded',
        icons = {
          package_installed = '',
          package_pending = '󰇘',
          package_uninstalled = '',
        },
      },
      ensure_installed = {
        'stylua',
        'shfmt',
        'prettierd',
        'beautysh',
        'shellcheck',
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
}
