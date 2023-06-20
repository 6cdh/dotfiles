vim.keymap.set("n", "<leader>cp", "<cmd>%y+<cr>", { noremap = true })
vim.keymap.set("x", "<leader>cp", "\"+y", { noremap = true })

vim.keymap.set("n", "<C-/>", "<Plug>kommentary_line_default", { noremap = true })
vim.keymap.set("v", "<C-/>", "<Plug>kommentary_visual_default", { noremap = true })

vim.keymap.set("n", "<esc>", "<cmd>noh<cr>")
