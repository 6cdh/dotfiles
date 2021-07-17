require'packer'.startup(
    function(use) -- Suppress undefined global variables warnings
        use 'wbthomason/packer.nvim'

        -- lsp
        use {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            config = function() require 'treesitter' end
        }
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
        use {'hrsh7th/nvim-compe', config = function() require 'complete' end}
        use {
            'tzachar/compe-tabnine',
            run = './install.sh',
            requires = 'hrsh7th/nvim-compe'
        }

        -- languages
        use {
            'plasticboy/vim-markdown',
            ft = {'markdown'},
            disable = true,
            config = function()
                -- disable the folding configuration
                vim.g.vim_markdown_folding_disabled = 1
                -- enable conceal
                vim.g.vim_markdown_conceal = 1
                -- Latex math syntax
                vim.g.vim_markdown_math = 1
                -- Strikethrough uses two tildes
                vim.g.vim_markdown_strikethrough = 1
                -- Enable TOC Autofit
                vim.g.vim_markdown_toc_autofit = 1
            end
        }
        use {
            'iamcco/markdown-preview.nvim',
            run = 'cd app && yarn install',
            cmd = 'MarkdownPreview'
        }

        -- ui
        use 'kyazdani42/nvim-web-devicons'
        use 'mhinz/vim-startify'
        use {
            'akinsho/nvim-bufferline.lua',
            config = function()
                require'bufferline'.setup {
                    options = {
                        mappings = false,
                        show_close_icon = false,
                        always_show_bufferline = false
                    }
                }
            end
        }
        use {'famiu/feline.nvim', config = function()
            require 'statusline'
        end}
        use {'hoob3rt/lualine.nvim', config = function()
            require 'statusline'
        end}
        use 'kdav5758/TrueZen.nvim'
        use {
            'norcalli/nvim-colorizer.lua',
            config = function() require'colorizer'.setup() end
        }
        use 'xiyaowong/nvim-cursorword'
        use 'haringsrob/nvim_context_vt'

        -- explorer
        use {
            'kyazdani42/nvim-tree.lua',
            requires = 'kyazdani42/nvim-web-devicons',
            config = function()
                vim.g.nvim_tree_auto_open = 1
                vim.g.nvim_tree_auto_ignore_ft = {'startify'}
            end
        }
        use {'kevinhwang91/rnvimr', cmd = 'RnvimrToggle'}
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
        use {
            'b3nj5m1n/kommentary',
            config = function()
                vim.g.kommentary_create_default_mappings = false
                local kc = require 'kommentary.config'
                kc.configure_language('default',
                                      {prefer_single_line_comments = true})
            end
        }
        use {'windwp/nvim-autopairs', config = function() require 'pairs' end}
        use 'tpope/vim-surround'
        use 'godlygeek/tabular'
        use {'metakirby5/codi.vim', cmd = 'Codi'}
        use {'mizlan/iswap.nvim', cmd = 'ISwap'}

        -- diagnostic
        use 'dstein64/vim-startuptime'

        -- color scheme
        use 'ful1e5/onedark.nvim'
    end)
