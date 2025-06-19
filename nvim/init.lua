-- Set the size of tab for identation
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- Set the number of lines to be relative
vim.opt.number = true
vim.opt.relativenumber = true

-- Set the leader key
vim.g.mapleader = " "

-- Shortcuts for buff navigation
vim.keymap.set("n", "<leader>bc", ":enew<CR>", { desc = "Create new buffer" })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Delete current buffer" })
vim.keymap.set("n", "<leader>bn", ":bprev<CR>", { desc = "Go to previous buffer" })
vim.keymap.set("n", "<leader>bm", ":bnext<CR>", { desc = "Go to next buffer" })

-- Navigate vim panes better
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>", { desc = "Move to left pane" })
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>", { desc = "Move to lower pane" })
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>", { desc = "Move to upper pane" })
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>", { desc = "Move to right pane" })

-- New keymaps for pane creation and closing
vim.keymap.set("n", "<leader>ws", ":wincmd s<CR>", { desc = "Create horizontal split" })
vim.keymap.set("n", "<leader>wv", ":wincmd v<CR>", { desc = "Create vertical split" })
vim.keymap.set("n", "<leader>wc", ":wincmd c<CR>", { desc = "Close current window" })
vim.keymap.set("n", "<leader>bs", ":split | enew<CR>", { desc = "Create new buffer in horizontal split" })
vim.keymap.set("n", "<leader>bv", ":vsplit | enew<CR>", { desc = "Create new buffer in vertical split" })

-- Load all the plugins and configurations
require("config.lazy")
