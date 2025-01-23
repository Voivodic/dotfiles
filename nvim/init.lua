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
vim.keymap.set("n", "<leader>bc", ":enew<CR>", {})
vim.keymap.set("n", "<leader>bd", ":bd<CR>", {})
vim.keymap.set("n", "<leader>bn", ":bprev<CR>", {})
vim.keymap.set("n", "<leader>bm", ":bnext<CR>", {})

-- Navigate vim panes better
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- Load all the plugins and configurations
require("config.lazy")
