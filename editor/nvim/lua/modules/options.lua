local indent = 4
local textwidth = 90

vim.opt["textwidth"] = textwidth
vim.opt["expandtab"] = true
vim.opt["tabstop"] = indent
vim.opt["shiftwidth"] = indent
vim.opt["softtabstop"] = indent
vim.opt["background"] = "light"
vim.opt["splitright"] = true
vim.opt["splitbelow"] = true
vim.opt["foldmethod"] = "marker"
vim.opt["wrap"] = true
vim.opt["linebreak"] = true
vim.opt["inccommand"] = "nosplit"
vim.opt["lazyredraw"] = true
vim.opt["updatetime"] = 700
vim.opt["timeoutlen"] = 300
vim.opt["ignorecase"] = true
vim.opt["smartcase"] = true
vim.opt["showmatch"] = true
vim.opt["matchtime"] = 2
vim.opt["cmdheight"] = 1
vim.opt["pumheight"] = 10
vim.opt["completeopt"] = { "menu", "menuone", "noselect" }
vim.opt["magic"] = true
vim.opt["undofile"] = true
vim.opt["termguicolors"] = true
vim.opt["relativenumber"] = false
vim.opt["signcolumn"] = "yes"
vim.opt["mouse"] = "a"
vim.opt["scrolloff"] = 1
vim.opt["sidescrolloff"] = 5
vim.opt["backup"] = false
vim.opt["swapfile"] = false
vim.opt["writebackup"] = false
vim.opt["ruler"] = false
vim.opt["showmode"] = false

vim.g["netrw_banner"] = 0
vim.g["netrw_winsize"] = 25
vim.g["netrw_browse_split"] = 4
vim.g.mapleader = " "
vim.opt.shortmess:append("cI")

if vim.g.vscode == nil then
    vim.opt.number = true
    vim.opt.syntax = "on"
    vim.opt.laststatus = 2
    vim.opt["cursorline"] = true
else
    vim.opt.number = false
    vim.opt.syntax = "off"
    vim.opt.laststatus = 0
    vim.opt["cursorline"] = false
end
