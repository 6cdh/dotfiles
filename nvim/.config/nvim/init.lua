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

    -- dap
    use 'mfussenegger/nvim-dap'

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
    use 'norcalli/nvim-colorizer.lua'

    -- utils
    use 'tpope/vim-repeat'
    use {'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim'}
    use 'lambdalisue/suda.vim'
    use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons'}
    use 'akinsho/nvim-toggleterm.lua'
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }

    -- coding
    use 'sbdchd/neoformat'
    use 'terrortylor/nvim-comment'
    use 'windwp/nvim-autopairs'
    use 'metakirby5/codi.vim'
    use 'godlygeek/tabular'

    -- diagnostic
    use 'dense-analysis/ale'
    use 'nathunsmitty/nvim-ale-diagnostic'

    -- color scheme
    use 'Th3Whit3Wolf/one-nvim'
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

-- For barbar.nvim
opts.global.mouse = 'a'

cmd [[set shortmess+=c]]

-- cmd [[filetype plugin on]]
-- cmd [[filetype indent on]]

opts.global.termguicolors = true
cmd [[colorscheme one-nvim]]

cmd [[autocmd BufWritePost plugins.lua PackerCompile]]

g.python3_host_prog = '~/.pyenv/versions/nvim/bin/python3'

-- Keymaps
local km = require 'keymap'

km.map(km.mode.normal, '<leader>w', km.cmd('w'), km.mk(km.opts.noremap))
km.map(km.mode.normal, '<leader>q', km.cmd('q'), km.mk(km.opts.noremap))
km.map(km.mode.normal, '<leader>Q', km.cmd('q!'), km.mk(km.opts.noremap))
km.map(km.mode.normal, '<C-j>', '<C-w>j', km.mk(km.opts.noremap))
km.map(km.mode.normal, '<C-k>', '<C-w>k', km.mk(km.opts.noremap))
km.map(km.mode.normal, '<C-h>', '<C-w>h', km.mk(km.opts.noremap))
km.map(km.mode.normal, '<C-l>', '<C-w>l', km.mk(km.opts.noremap))
km.map(km.mode.terminal, '<C-j>', [[<C-\><C-n><C-w>j]], km.mk(km.opts.noremap))
km.map(km.mode.terminal, '<C-k>', [[<C-\><C-n><C-w>k]], km.mk(km.opts.noremap))
km.map(km.mode.terminal, '<C-h>', [[<C-\><C-n><C-w>h]], km.mk(km.opts.noremap))
km.map(km.mode.terminal, '<C-l>', [[<C-\><C-n><C-w>l]], km.mk(km.opts.noremap))

km.map(km.mode.normal, '<leader>cp', km.cmd('%y+'), km.mk(km.opts.noremap))
km.map(km.mode.visual, '<leader>cp', '\"+y', km.mk(km.opts.noremap))

km.map(km.mode.normal, '<leader>hpp', km.cmd('set filetype=cpp'),
       km.mk(km.opts.noremap))

km.map(km.mode.normal, '<leader>tm', km.cmd('terminal'), km.mk(km.opts.noremap))

km.map(km.mode.normal, '<leader>nf', km.cmd('Neoformat'), km.mk(km.opts.noremap))
km.map(km.mode.visual, '<leader>nf', km.cmd('Neoformat'), km.mk(km.opts.noremap))

km.map(km.mode.normal, '<leader>nt', km.cmd('NvimTreeToggle'),
       km.mk(km.opts.noremap))

km.map(km.mode.normal, '<leader>nc', km.cmd('CommentToggle'),
       km.mk(km.opts.noremap))
km.map(km.mode.visual, '<leader>nc', km.cmd('CommentToggle'),
       km.mk(km.opts.noremap))
km.map(km.mode.normal, '<leader>ci', km.cmd('Codi'), km.mk(km.opts.noremap))

-- packer
km.map(km.mode.normal, '<leader>pi', km.cmd('PackerInstall'),
       km.mk(km.opts.noremap))
km.map(km.mode.normal, '<leader>ps', km.cmd('PackerSync'),
       km.mk(km.opts.noremap))

-- fast make
km.map(km.mode.normal, '<leader>mk', ':!make', km.mk(km.opts.noremap))

-- easy align
km.map(km.mode.visual, '<leader>ea', '<Plug>(EasyAlgin)', km.mk(km.opts.noremap))
km.map(km.mode.normal, '<leader>ea', '<Plug>(EasyAlgin)', km.mk(km.opts.noremap))

-- barbar.nvim
km.map(km.mode.normal, '<A-<>', km.cmd('BufferPrevious'), km.mk(km.opts.noremap))
km.map(km.mode.normal, '<A->>', km.cmd('BufferNext'), km.mk(km.opts.noremap))
km.map(km.mode.normal, '<A-q>', km.cmd('BufferGoto 1'), km.mk(km.opts.noremap))
km.map(km.mode.normal, '<A-w>', km.cmd('BufferGoto 2'), km.mk(km.opts.noremap))
km.map(km.mode.normal, '<A-e>', km.cmd('BufferGoto 3'), km.mk(km.opts.noremap))
km.map(km.mode.normal, '<A-r>', km.cmd('BufferGoto 4'), km.mk(km.opts.noremap))
km.map(km.mode.normal, '<A-c>', km.cmd('BufferClose'), km.mk(km.opts.noremap))
km.map(km.mode.normal, '<A-m>', km.cmd('BufferPick'), km.mk(km.opts.noremap))

-- telescope
km.map(km.mode.normal, '<leader>ff', km.cmd('Telescope find_files'),
       km.mk(km.opts.noremap))
km.map(km.mode.normal, '<leader>fg', km.cmd('Telescope live_grep'),
       km.mk(km.opts.noremap))
km.map(km.mode.normal, '<leader>fb', km.cmd('Telescope buffers'),
       km.mk(km.opts.noremap))
km.map(km.mode.normal, '<leader>fh', km.cmd('Telescope help_tags'),
       km.mk(km.opts.noremap))

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

-- nvim-toggleterm
require'toggleterm'.setup {
    size = 10,
    open_mapping = '<leader>tt',
    insert_mappings = false,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 1,
    start_in_insert = true,
    persist_size = true,
    direction = 'horizontal'
}

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
km.map(km.mode.normal, '<leader>W', km.cmd('SudaWrite'), km.mk(km.opts.noremap))
km.map(km.mode.normal, '<leader>sdr', km.cmd('SudaRead'), km.mk(km.opts.noremap))

