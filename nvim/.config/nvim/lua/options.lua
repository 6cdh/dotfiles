local indent = 4
local textwidth = 90

local global = vim.o

global.textwidth = textwidth
global.expandtab = true
global.tabstop = indent
global.shiftwidth = indent
global.softtabstop = indent
global.inccommand = 'nosplit'
global.lazyredraw = true
global.breakindent = true
global.updatetime = 100
global.timeoutlen = 1000
global.smartcase = true
global.ignorecase = true
global.showmode = false
global.cmdheight = 2
global.completeopt = 'menuone,noselect'
global.magic = true
global.backup = false
global.writebackup = false
global.swapfile = false
-- For bufferline
global.mouse = 'a'
global.termguicolors = true

local window = vim.wo

window.number = true
window.relativenumber = true
window.cursorline = true
window.signcolumn = 'yes'

local buffer = vim.bo

buffer.expandtab = true
buffer.tabstop = indent
buffer.shiftwidth = indent
buffer.softtabstop = indent

vim.g.onedark_dark_sidebar = false
vim.g.python3_host_prog = '~/.pyenv/versions/nvim/bin/python3'

local cmd = vim.api.nvim_command

cmd [[set foldmethod=marker]]
cmd [[set shortmess+=c]]
cmd [[colorscheme onedark]]

