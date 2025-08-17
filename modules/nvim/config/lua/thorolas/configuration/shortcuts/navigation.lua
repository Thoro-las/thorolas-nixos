local kw = require("thorolas.utility.keymaps")

kw.mapd("n", "<leader>o", "o<ESC>", "Empty Line After")
kw.mapd("n", "<leader>O", "O<ESC>", "Empty Line Before")
kw.mapd("n", "<leader>i", "o<ESC>O", "Empty Surrounding")

kw.maps("t", "<C-h>", "<C-\\><C-N><C-w>h", "Move To Left Window")
kw.maps("t", "<C-j>", "<C-\\><C-N><C-w>j", "Move To Bottom Window")
kw.maps("t", "<C-k>", "<C-\\><C-N><C-w>k", "Move To Top Window")
kw.maps("t", "<C-l>", "<C-\\><C-N><C-w>l", "Move To Right Window")

kw.mapsnr("n", "<C-h>", "<C-w>h", "Go To Left Window")
kw.mapsnr("n", "<C-j>", "<C-w>j", "Go To Bottom Window")
kw.mapsnr("n", "<C-k>", "<C-w>k", "Go To Top Window")
kw.mapsnr("n", "<C-l>", "<C-w>l", "Go To Right Window")

kw.mapsnr("n", "<C-up>", ":resize -2<CR>", "Shrink Window Vertically")
kw.mapsnr("n", "<C-down>", ":resize +2<CR>", "Spread Window Vertically")
kw.mapsnr("n", "<C-left>", ":vertical resize +2<CR>", "Shrink Window Horizontally")
kw.mapsnr("n", "<C-right>", ":vertical resize -2<CR>", "Spread Window Horizontally")

kw.mapsnr("n", "<tab>", ":bnext<CR>", "Go To Next Buffer")
kw.mapsnr("n", "<s-tab>", ":bprevious<CR>", "Go To Previous Buffer")

kw.command("[d", "lua vim.diagnostic.goto_prev()", "Go To Next Diagnostic")
kw.command("]d", "lua vim.diagnostic.goto_next()", "Go To Previous Diagnostic")
