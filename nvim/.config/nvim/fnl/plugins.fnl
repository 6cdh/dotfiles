(local packer (require :packer))

(let [utils (require :utils)]
  (utils.new_augroup {:fennel_packer ["BufWritePost plugins.fnl PackerCompile"]}))

(packer.startup (fn [use]
                  (macro plug [name tbl]
                    (local tbl (or tbl {}))
                    (tset tbl 1 name)
                    `(use ,tbl))
                  (macro setup [m f ...]
                    `((. (require ,m) ,f) ,...))
                  (plug :wbthomason/packer.nvim)
                  (plug :rktjmp/hotpot.nvim)
                  ;; lsp
                  (plug :nvim-treesitter/nvim-treesitter
                        {:run ":TSUpdate" :config #(require :treesitter)})
                  (plug :p00f/nvim-ts-rainbow)
                  (plug :nvim-treesitter/playground {:cmd :TSPlaygroundToggle})
                  (plug :neovim/nvim-lspconfig)
                  (plug :glepnir/lspsaga.nvim
                        {:config #(setup :lspsaga :init_lsp_saga
                                         {:code_action_prompt {:virtual_text false}})})
                  (plug :onsails/lspkind-nvim)
                  (plug :ray-x/lsp_signature.nvim
                        {:config #(setup :lsp_signature :on_attach)})
                  (plug :folke/trouble.nvim
                        {:cmd :Trouble :config #(setup :trouble :setup)})
                  (plug :folke/todo-comments.nvim
                        {:requires :nvim-lua/plenary.nvim
                         :config #(setup :todo-comments :setup)})
                  ;; dap
                  (plug :mfussenegger/nvim-dap)
                  ;; completion
                  (plug :hrsh7th/vim-vsnip)
                  (plug :hrsh7th/nvim-compe
                        {:event :InsertEnter :config #(require :complete)})
                  (plug :tzachar/compe-tabnine
                        {:after :nvim-compe
                         :run :./install.sh
                         :requires :hrsh7th/nvim-compe})
                  ;; langs
                  (plug :plasticboy/vim-markdown
                        {:disable true
                         :ft :markdown
                         :config #(do
                                    (set vim.g.vim_markdown_folding_disabled 1)
                                    (set vim.g.vim_markdown_conceal 1)
                                    (set vim.g.vim_markdown_math 1)
                                    (set vim.g.vim_markdown_strikethrough 1)
                                    (set vim.g.vim_markdown_toc_autofit 1))})
                  (plug :iamcco/markdown-preview.nvim
                        {:run "cd app && yarn install" :cmd :MarkdownPreview})
                  ;; ui
                  (plug :kyazdani42/nvim-web-devicons) ; (plug :mhinz/vim-startify)
                  (plug :akinsho/nvim-bufferline.lua
                        {:config #(setup :bufferline :setup
                                         {:options {:mappings true
                                                    :show_close_icon false
                                                    :always_show_bufferline false}})})
                  (plug :famiu/feline.nvim {:config #(require :statusline)})
                  (plug :kdav5758/TrueZen.nvim)
                  (plug :norcalli/nvim-colorizer.lua
                        {:config #(setup :colorizer :setup)})
                  (plug :xiyaowong/nvim-cursorword)
                  (plug :haringsrob/nvim_context_vt)
                  ;; explorer
                  (plug :kyazdani42/nvim-tree.lua
                        {:cmd :NvimTreeToggle
                         :requires :kyazdani42/nvim-web-devicons})
                  (plug :kevinhwang91/rnvimr {:cmd :RnvimrToggle})
                  (plug :nvim-telescope/telescope.nvim
                        {:requires [[:nvim-lua/popup.nvim]
                                    [:nvim-lua/plenary.nvim]]})
                  ;; git
                  (plug :lewis6991/gitsigns.nvim
                        {:requires :nvim-lua/plenary.nvim
                         :config #(setup :gitsigns :setup)})
                  ;; utils
                  (plug :tpope/vim-repeat)
                  (plug :karb94/neoscroll.nvim
                        {:config #(setup :neoscroll :setup)})
                  (plug :lambdalisue/suda.vim
                        {:config #(tset vim :g "suda#prompt"
                                        "[sudo] password: ")})
                  (plug :akinsho/nvim-toggleterm.lua
                        {:cmd :ToggleTerm
                         :config #(setup :toggleterm :setup
                                         {:size 10
                                          :insert_mappings false
                                          :shade_filetypes {}
                                          :shade_terminals true
                                          :shading_factor 1
                                          :start_in_insert true
                                          :persist_size true
                                          :direction :float})})
                  (plug :folke/which-key.nvim
                        {:config #(setup :which-key :setup)})
                  ;; coding
                  (plug :b3nj5m1n/kommentary
                        {:config #(do
                                    (tset vim :g
                                          :kommentary_create_default_mappings
                                          false)
                                    (setup :kommentary.config
                                           :configure_language :default
                                           {:prefer_single_line_comments true}))})
                  (plug :windwp/nvim-autopairs {:config #(require :pairs)})
                  (plug :tpope/vim-surround)
                  (plug :godlygeek/tabular)
                  (plug :metakirby5/codi.vim {:cmd :Codi})
                  (plug :mizlan/iswap.nvim {:cmd :ISwap})
                  ;; diagnostic
                  (plug :dstein64/vim-startuptime {:cmd :StartupTime})
                  ;; color scheme
                  (plug :ful1e5/onedark.nvim)))

