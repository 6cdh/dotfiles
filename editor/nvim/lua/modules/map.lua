vim.keymap.set("n", "<leader>cp", "<cmd>%y+<cr>", { noremap = true })
vim.keymap.set("x", "<leader>cp", "\"+y", { noremap = true })

if vim.g.vscode == nil then
    vim.keymap.set("n", "<C-_>", "<Plug>kommentary_line_default", { noremap = true })
    vim.keymap.set("v", "<C-_>", "<Plug>kommentary_visual_default", { noremap = true })
end

vim.keymap.set("n", "<esc>", "<cmd>noh<cr>")

