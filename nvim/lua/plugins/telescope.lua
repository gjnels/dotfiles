return {
  -- fuzzy finder (files, LSP, etc)
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        -- fuzzy finder algorithm which requires local dependencies to be built
        -- requires 'make' to be installed, don't load if 'make' is not installed
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable('make') == 1
        end,
        config = function()
          require('telescope').load_extension('fzf')
        end,
      },
    },
    keys = {},
    opts = {
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    },
    config = function()
      local builtin = require('telescope.builtin')
      local set = vim.keymap.set
      -- telescope keybindings
      -- see `:h telescope.builtin`
      set('n', '<Leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
      set('n', '<Leader><Space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      set('n', '<Leader>/', function()
        -- optionally pass additional configuration to telescope to change theme, layout, etc
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
          windblend = 10,
          previewer = true,
        }))
      end, { desc = '[/] Search current buffer' })
      set('n', '<Leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
      set('n', '<Leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      set('n', '<Leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      set('n', '<Leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      set('n', '<Leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      set('n', '<Leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    end,
  }
