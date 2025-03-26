require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "window left" })
map("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "window down" })
map("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "window up" })
map("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "window right" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "save" })
map("n", "<leader>q", "<cmd> q <cr>", { desc = "quit" })
map("n", "<C-F>", '<cmd> lua require("conform").format()<CR>', { desc = "format" })
map("n", "[d", "<cmd> lua vim.diagnostic.goto_prev()<CR>", { desc = "go to prev diagnostic" })
map("n", "]d", "<cmd> lua vim.diagnostic.goto_next()<CR>", { desc = "go to next diagnostic" })
map("i", "jj", "<ESC>", { noremap = true, silent = true })
