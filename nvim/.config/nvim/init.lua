---@diagnostic disable: undefined-global
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g

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

    -- lsp
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'p00f/nvim-ts-rainbow'
    use 'nvim-treesitter/playground'
    use 'neovim/nvim-lspconfig'
    use 'glepnir/lspsaga.nvim'
    use 'onsails/lspkind-nvim'
    use 'ray-x/lsp_signature.nvim'

    -- completion
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
    use 'hrsh7th/nvim-compe'
    use {
        'tzachar/compe-tabnine',
        run = './install.sh',
        requires = 'hrsh7th/nvim-compe'
    }

    -- languages
    use {'plasticboy/vim-markdown', ft = {'markdown'}}
    use {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install',
        ft = {'markdown'}
    }

    -- vision
    use 'kyazdani42/nvim-web-devicons'
    use 'mhinz/vim-startify'
    use 'romgrk/barbar.nvim'
    use {'lukas-reineke/indent-blankline.nvim', branch = 'lua'}
    use 'famiu/feline.nvim'
    -- use {
    --     'glepnir/galaxyline.nvim',
    --     branch = 'main',
    --     requires = {'kyazdani42/nvim-web-devicons'}
    -- }

    -- utils
    use 'tpope/vim-repeat'
    use {'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim'}
    use 'lambdalisue/suda.vim'
    use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons'}
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }

    -- coding
    use 'sbdchd/neoformat'
    use 'terrortylor/nvim-comment'
    use 'windwp/nvim-autopairs'
    use 'metakirby5/codi.vim'
    use 'junegunn/vim-easy-align'

    -- diagnostic
    use 'dense-analysis/ale'
    use 'nathunsmitty/nvim-ale-diagnostic'

    -- color scheme
    use 'Th3Whit3Wolf/one-nvim'
    use 'norcalli/nvim-colorizer.lua'
end)

-- General
local opts = {global = vim.o, buffer = vim.bo, window = vim.wo}

opts.window.number = true
opts.window.relativenumber = true

opts.global.textwidth = 90

local indent = 4

opts.global.expandtab = true
opts.buffer.expandtab = true
opts.global.tabstop = indent
opts.buffer.tabstop = indent
opts.global.shiftwidth = indent
opts.buffer.shiftwidth = indent
opts.global.softtabstop = indent
opts.buffer.softtabstop = indent

opts.global.smartcase = true
opts.global.ignorecase = true

opts.global.showmode = false

opts.window.signcolumn = 'yes:2'

opts.global.completeopt = 'menuone,noselect'

opts.global.magic = true
opts.global.backup = false
opts.global.writebackup = false
opts.global.swapfile = false

cmd [[set shortmess+=c]]

-- cmd [[filetype plugin on]]
-- cmd [[filetype indent on]]

opts.global.termguicolors = true
cmd [[colorscheme one-nvim]]

cmd [[autocmd BufWritePost plugins.lua PackerCompile]]

g.python3_host_prog = '~/.pyenv/versions/nvim/bin/python3'

-- Keymaps
local km = require 'keymap'

km.map(km.mode.normal, '<leader>w', ':w<CR>', km.mk(km.opts.noremap))
km.map(km.mode.normal, '<leader>q', ':q<CR>', km.mk(km.opts.noremap))
km.map(km.mode.normal, '<leader>Q', ':q!<CR>', km.mk(km.opts.noremap))
km.map(km.mode.normal, '<C-j>', '<C-w>j', km.mk(km.opts.noremap))
km.map(km.mode.normal, '<C-k>', '<C-w>k', km.mk(km.opts.noremap))
km.map(km.mode.normal, '<C-h>', '<C-w>h', km.mk(km.opts.noremap))
km.map(km.mode.normal, '<C-l>', '<C-w>l', km.mk(km.opts.noremap))
km.map(km.mode.terminal, '<C-j>', [[<C-\><C-n><C-w>j]], km.mk(km.opts.noremap))
km.map(km.mode.terminal, '<C-k>', [[<C-\><C-n><C-w>k]], km.mk(km.opts.noremap))
km.map(km.mode.terminal, '<C-h>', [[<C-\><C-n><C-w>h]], km.mk(km.opts.noremap))
km.map(km.mode.terminal, '<C-l>', [[<C-\><C-n><C-w>l]], km.mk(km.opts.noremap))

km.map(km.mode.normal, '<leader>cp', ':%y+<CR>', km.mk(km.opts.noremap))
km.map(km.mode.visual, '<leader>cp', '\"+y', km.mk(km.opts.noremap))

km.map(km.mode.normal, '<leader>hpp', ':set filetype=cpp<CR>',
       km.mk(km.opts.noremap))

km.map(km.mode.normal, '<leader>tm', ':terminal<CR>', km.mk(km.opts.noremap))

km.map(km.mode.normal, '<leader>f', ':Neoformat<CR>', km.mk(km.opts.noremap))
km.map(km.mode.visual, '<leader>f', ':Neoformat<CR>', km.mk(km.opts.noremap))

km.map(km.mode.normal, '<leader>nt', ':NvimTreeToggle<CR>',
       km.mk(km.opts.noremap))

km.map(km.mode.normal, '<leader>nc', ':CommentToggle<CR>',
       km.mk(km.opts.noremap))
km.map(km.mode.visual, '<leader>nc', ':CommentToggle<CR>',
       km.mk(km.opts.noremap))
km.map(km.mode.normal, '<leader>ci', ':Codi<CR>', km.mk(km.opts.noremap))

-- packer
km.map(km.mode.normal, '<leader>pi', ':PackerInstall<CR>',
       km.mk(km.opts.noremap))
km.map(km.mode.normal, '<leader>ps', ':PackerStatus<CR>', km.mk(km.opts.noremap))

-- fast make
km.map(km.mode.normal, '<leader>mk', ':!make', km.mk(km.opts.noremap))

-- easy align
km.map(km.mode.visual, '<leader>ea', '<Plug>(EasyAlgin)', km.mk(km.opts.noremap))
km.map(km.mode.normal, '<leader>ea', '<Plug>(EasyAlgin)', km.mk(km.opts.noremap))

-- treesitter
require 'treesitter'

-- lsp
require 'lsp'
require 'diagnostic'

-- compe
require 'complete'

-- neoformat
require 'fmt'

-- gitsigns
require'gitsigns'.setup()

-- statusline
require 'statusline'

-- comment
require'nvim_comment'.setup()

-- nvim-autopairs
require'nvim-autopairs'.setup()

-- colorizer
require'colorizer'.setup()

-- lsp_signature
require'lsp_signature'.on_attach()

-- vim markdown

-- disable the folding configuration
g.vim_markdown_folding_disabled = 1
-- enable conceal
g.vim_markdown_conceal = 1
-- Latex math syntax
g.vim_markdown_math = 1
-- Strikethrough uses two tildes
g.vim_markdown_strikethrough = 1
-- Enable TOC Autofit
g.vim_markdown_toc_autofit = 1

-- suda
g['suda#prompt'] = '[sudo] Password: '
km.map(km.mode.normal, '<leader>W', ':SudaWrite<CR>', km.mk(km.opts.noremap))
km.map(km.mode.normal, '<leader>sdr', ':SudaRead<CR>', km.mk(km.opts.noremap))

