-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>.
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", "<cmd>echo 'Use h to move!!'<CR>")
vim.keymap.set("n", "<right>", "<cmd>echo 'Use l to move!!'<CR>")
vim.keymap.set("n", "<up>", "<cmd>echo 'Use k to move!!'<CR>")
vim.keymap.set("n", "<down>", "<cmd>echo 'Use j to move!!'<CR>")

-- Use J and K to move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep selection when changing indent in visual mode
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Center current line in the screen after jumping up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- Jump through quickfix-error-list, centering the current line in the screen
vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz", { desc = "Go to previous [Q]uickfix location" })
vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz", { desc = "Go to next [Q]uickfix location" })
vim.keymap.set("n", "[Q", "<cmd>cfirst<CR>zz", { desc = "Go to first [Q]uickfix location" })
vim.keymap.set("n", "]Q", "<cmd>clast<CR>zz", { desc = "Go to last [Q]uickfix location" })
vim.keymap.set("n", "[<C-q>", "<cmd>cpfile<CR>zz", { desc = "Go to previous-file last [Q]uickfix location" })
vim.keymap.set("n", "]<C-q>", "<cmd>cnfile<CR>zz", { desc = "Go to next-file first [Q]uickfix location" })

-- Shortcut to copy into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>+", "<cmd>let @+=@0<CR>", { desc = "Copy last yank to system clipboard" })

-- Shortcut for closing/deleting buffers
vim.keymap.set("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>X", "<cmd>%bdelete<CR>", { desc = "Close all buffers" })

