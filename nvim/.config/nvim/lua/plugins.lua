require'utils'.new_augroup {packer = {'BufWritePost plugins.lua PackerCompile'}}

require'packer'.startup(
    function(use) -- Suppress undefined global variables warnings
        use 'wbthomason/packer.nvim'

        -- lsp
        use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
        use 'p00f/nvim-ts-rainbow'
        use 'nvim-treesitter/playground'
        use 'neovim/nvim-lspconfig'
        use {
            'glepnir/lspsaga.nvim',
            config = function() require'lspsaga'.init_lsp_saga() end
        }
        use 'onsails/lspkind-nvim'
        use {
            'ray-x/lsp_signature.nvim',
            config = function() require'lsp_signature'.on_attach() end
        }
        use {
            "folke/trouble.nvim",
            config = function() require("trouble").setup() end
        }

        -- dap
        use 'mfussenegger/nvim-dap'

        -- completion
        use 'hrsh7th/vim-vsnip'
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
        use {
            'akinsho/nvim-bufferline.lua',
            config = function()
                require'bufferline'.setup {
                    options = {mappings = false, always_show_bufferline = false}
                }
            end
        }
        use {
            'lukas-reineke/indent-blankline.nvim',
            branch = 'lua',
            disable = true
        }
        use 'famiu/feline.nvim'
        use 'kdav5758/TrueZen.nvim'
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
            config = function()
                vim.g['suda#prompt'] = '[sudo] Password: '
            end
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
        use {
            'b3nj5m1n/kommentary',
            config = function()
                vim.g.kommentary_create_default_mappings = false
                local kc = require 'kommentary.config'
                kc.configure_language('default',
                                      {prefer_single_line_comments = true})
            end
        }
        use {
            'windwp/nvim-autopairs',
            config = function() require'nvim-autopairs'.setup() end
        }
        use {
            'blackCauldron7/surround.nvim',
            config = function() require'surround'.setup {} end
        }
        use 'godlygeek/tabular'
        use {'metakirby5/codi.vim'}

        -- diagnostic
        use 'dense-analysis/ale'
        use 'nathunsmitty/nvim-ale-diagnostic'
        use 'dstein64/vim-startuptime'

        -- color scheme
        use {'monsonjeremy/onedark.nvim'}
    end)
