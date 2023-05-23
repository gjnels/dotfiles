return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    opts = {
      -- languages always installed
      ensure_installed = {
        'bash',
        'go',
        'html',
        'javascript',
        'json',
        'json5',
        'jsonc',
        'lua',
        'svelte',
        'tsx',
        'typescript',
        'vimdoc',
        'vim',
      },
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
            ['ac'] = '@class.outer', -- [a]round [c]lass
            ['ic'] = '@class.inner', -- [i]nside [c]lass
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
    },
  },
}
