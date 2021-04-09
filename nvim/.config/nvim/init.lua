local cmd = vim.cmd
local fn = vim.fn
local g = vim.g

local indent = 4

g.mapleader = ' '

-- Plugins

-- packer.nvim
local packer_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(packer_path)) > 0 then
    cmd([[!git clone https://github.com/wbthomason/packer.nvim --depth 1]] ..
            packer_path)
    cmd [[packadd packer.nvim]]
end

packer = require 'packer'

packer.startup(function()
    use 'wbthomason/packer.nvim'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/playground'
    use 'neovim/nvim-lspconfig'

    use 'hrsh7th/nvim-compe'
    use {
        'tzachar/compe-tabnine',
        run = './install.sh',
        requires = 'hrsh7th/nvim-compe'
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }

    use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        requires = {'kyazdani42/nvim-web-devicons'}
    }

    use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons'}

    use 'p00f/nvim-ts-rainbow'

    use 'sbdchd/neoformat'

    use 'glepnir/lspsaga.nvim'

    use 'hrsh7th/vim-vsnip'

    use 'onsails/lspkind-nvim'

    use 'dense-analysis/ale'
    use 'nathunsmitty/nvim-ale-diagnostic'

    use 'joshdick/onedark.vim'
end)

-- General Conf

local opts = {global = vim.o, buffer = vim.bo, window = vim.wo}

opts.window.number = true
opts.window.relativenumber = true

opts.global.textwidth = 90

opts.global.expandtab = true
opts.global.tabstop = indent
opts.global.shiftwidth = indent
opts.global.softtabstop = indent
opts.global.smartindent = true

opts.global.smartcase = true
opts.global.ignorecase = true

opts.global.showmode = false

opts.global.completeopt = 'menuone,noselect'

opts.global.termguicolors = true
cmd [[colorscheme onedark]]

cmd [[autocmd BufWritePost plugins.lua PackerCompile]]

-- Keymaps
local km = require 'keymap'

km.map(km.mode.normal, '<leader>w', ':w<CR>', km.noremap)
km.map(km.mode.normal, '<leader>q', ':q<CR>', km.noremap)
km.map(km.mode.normal, '<leader>Q', ':q!<CR>', km.noremap)
km.map(km.mode.normal, '<C-j>', '<C-w>j', km.noremap)
km.map(km.mode.normal, '<C-k>', '<C-w>k', km.noremap)
km.map(km.mode.normal, '<C-h>', '<C-w>h', km.noremap)
km.map(km.mode.normal, '<C-l>', '<C-w>l', km.noremap)
km.map(km.mode.terminal, '<C-j>', [[<C-\><C-n><C-w>j]], km.noremap)
km.map(km.mode.terminal, '<C-k>', [[<C-\><C-n><C-w>k]], km.noremap)
km.map(km.mode.terminal, '<C-h>', [[<C-\><C-n><C-w>h]], km.noremap)
km.map(km.mode.terminal, '<C-l>', [[<C-\><C-n><C-w>l]], km.noremap)

km.map(km.mode.normal, '<leader>f', ':Neoformat<CR>', km.noremap)
km.map(km.mode.visual, '<leader>f', ':Neoformat<CR>', km.noremap)

km.map(km.mode.normal, '<leader>nt', ':NvimTreeToggle<CR>', km.noremap)

-- treesitter
require 'treesitter'

-- lsp
require 'lsp'
require 'diagnostic'

-- compe
require 'complete'

-- neoformat
require 'fmt'

-- statusline
require 'statusline'

