return {
  'nvim-neo-tree/neo-tree.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    {
      '<leader>fe',
      function()
        require('neo-tree.command').execute({ toggle = true, dir = vim.loop.cwd() })
      end,
    },
  },
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  init = function()
    vim.g.neo_tree_remove_legacy_commands = 1
    if vim.fn.argc() == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == 'directory' then
        require('neo-tree')
      end
    end
  end,
  opts = {
    filesystem = {
      bind_to_cws = false,
      follow_current_file = true,
      use_libuv_file_watcher = true,
    },
    window = {
      mappings = {
        ['<space>'] = 'none',
      },
    },
  },
  config = function(_, opts)
    require('neo-tree').setup(opts)
    vim.api.nvim_create_autocmd('TermClose', {
      pattern = '*lazygit',
      callback = function()
        if package.loaded['neo-tree.sources.git_status'] then
          require('neo-tree.sources.git_status').refresh()
        end
      end,
    })
  end,
}
