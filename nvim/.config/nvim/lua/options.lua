local indent = 4
local textwidth = 90

local cmd = vim.cmd
local global = vim.o
local buffer = vim.bo
local window = vim.wo

window.number = true
window.relativenumber = true

global.textwidth = textwidth

window.cursorline = true

global.expandtab = true
buffer.expandtab = true
global.tabstop = indent
buffer.tabstop = indent
global.shiftwidth = indent
buffer.shiftwidth = indent
global.softtabstop = indent
buffer.softtabstop = indent

global.inccommand = 'nosplit'

global.lazyredraw = true

global.breakindent = true

global.updatetime = 100
global.timeoutlen = 1000

global.smartcase = true
global.ignorecase = true

global.showmode = false

window.signcolumn = 'yes'

global.cmdheight = 2

global.completeopt = 'menuone,noselect'

global.magic = true
global.backup = false
global.writebackup = false
global.swapfile = false

cmd [[set foldmethod=marker]]

-- For barbar.nvim
global.mouse = 'a'

cmd [[set shortmess+=c]]

global.termguicolors = true
cmd [[colorscheme onedark]]

vim.g.python3_host_prog = '~/.pyenv/versions/nvim/bin/python3'
