local indent = 4
local textwidth = 90

vim.g.python3_host_prog = '~/.pyenv/versions/nvim/bin/python3'

local opt = vim.opt

opt.textwidth = textwidth
opt.expandtab = true
opt.tabstop = indent
opt.shiftwidth = indent
opt.softtabstop = indent
opt.inccommand = 'nosplit'
opt.lazyredraw = true
opt.breakindent = true
opt.updatetime = 100
opt.timeoutlen = 1000
opt.smartcase = true
opt.ignorecase = true
opt.showmode = false
opt.cmdheight = 2
opt.completeopt = 'menuone,noselect'
opt.magic = true
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- For bufferline
opt.mouse = 'a'
opt.termguicolors = true

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = 'yes'

opt.shortmess:append 'c'

