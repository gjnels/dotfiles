-- Additional keymaps to add to LazyVim

vim.keymap.set("i", "jk", "<esc>", { silent = true, desc = "Escape insert mode" })

-- navigate windows between neovim and tmux
vim.keymap.set("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>", { silent = true, desc = "Move to left window" })
vim.keymap.set("n", "<c-j>", "<cmd>TmuxNavigateUp<cr>", { silent = true, desc = "Move to upper window" })
vim.keymap.set("n", "<c-k>", "<cmd>TmuxNavigateDown<cr>", { silent = true, desc = "Move to lower window" })
vim.keymap.set("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>", { silent = true, desc = "Move to right window" })
