local cmd = vim.api.nvim_command
local fn = vim.fn
local g = vim.g

g.mapleader = ' '

-- packer.nvim {{{

local packer_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(packer_path)) > 0 then
    cmd('!git clone https://github.com/wbthomason/packer.nvim --depth 1' ..
            packer_path)
end

require'utils'.new_augroup {packer = {'BufWritePost init.lua PackerCompile'}}

-- }}}

-- Plugins {{{

local packer = require 'packer'

packer.startup(function(use) -- Suppress undefined global variables warnings
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
    use {
        'plasticboy/vim-markdown',
        ft = {'markdown'},
        config = function()
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
        end
    }
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
    use {
        'norcalli/nvim-colorizer.lua',
        config = function() require'colorizer'.setup() end
    }

    -- explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            vim.g.nvim_tree_auto_open = 1
            vim.g.nvim_tree_auto_ignore_ft = {'startify'}
        end
    }
    use 'kevinhwang91/rnvimr'
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }

    -- git
    use {
        'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function() require'gitsigns'.setup() end
    }

    -- utils
    use 'tpope/vim-repeat'
    use {
        'karb94/neoscroll.nvim',
        config = function() require'neoscroll'.setup() end
    }
    use {
        'lambdalisue/suda.vim',
        config = function() vim.g['suda#prompt'] = '[sudo] Password: ' end
    }
    use {
        'akinsho/nvim-toggleterm.lua',
        config = function()
            require'toggleterm'.setup {
                size = 10,
                insert_mappings = false,
                shade_filetypes = {},
                shade_terminals = true,
                shading_factor = 1,
                start_in_insert = true,
                persist_size = true,
                direction = 'float'
            }
        end
    }
    use {
        'folke/which-key.nvim',
        config = function() require'which-key'.setup() end
    }

    -- coding
    use 'sbdchd/neoformat'
    use 'terrortylor/nvim-comment'
    use {
        'windwp/nvim-autopairs',
        config = function() require'nvim-autopairs'.setup() end
    }
    use 'metakirby5/codi.vim'
    use 'godlygeek/tabular'

    -- diagnostic
    use 'dense-analysis/ale'
    use 'nathunsmitty/nvim-ale-diagnostic'
    use 'dstein64/vim-startuptime'

    -- color scheme
    use 'Th3Whit3Wolf/one-nvim'
end)

-- }}}

-- Import modules {{{

require 'options'
require 'comment'
require 'complete'
require 'diagnostic'
require 'fmt'
require 'lsp'
require 'keymap'
require 'statusline'
require 'treesitter'

-- }}}

