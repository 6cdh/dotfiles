(local packer (require :packer))

(packer.startup (fn [use]
                  (macro spec [name tbl]
                    (local tbl (or tbl {}))
                    (tset tbl 1 name)
                    tbl)
                  (macro plug [name tbl]
                    `(use (spec ,name ,tbl)))
                  (macro call [f ...]
                    `(,f ,...))
                  (macro module-conf [m f ...]
                    `(-> (require ,m) (. ,f) (call ,...)))
                  (macro setup [m ...]
                    `(module-conf ,m :setup ,...))
                  (plug :wbthomason/packer.nvim)
                  (plug :rktjmp/hotpot.nvim)
                  ;; lsp
                  (plug :nvim-treesitter/nvim-treesitter
                        {:run ":TSUpdate" :config #(require :treesitter)})
                  (plug :p00f/nvim-ts-rainbow)
                  (plug :nvim-treesitter/playground {:cmd :TSPlaygroundToggle})
                  (plug :neovim/nvim-lspconfig)
                  (plug :ray-x/lsp_signature.nvim
                        {:config #(setup :lsp_signature)})
                  (plug :folke/trouble.nvim
                        {:cmd :Trouble :config #(setup :trouble)})
                  (plug :folke/todo-comments.nvim
                        {:requires :nvim-lua/plenary.nvim
                         :config #(setup :todo-comments)})
                  ;; dap
                  (plug :mfussenegger/nvim-dap)
                  ;; completion
                  (plug :hrsh7th/nvim-cmp
                        {:event :InsertEnter
                         :config #(require :complete)
                         :requires [(spec :hrsh7th/cmp-nvim-lsp
                                          {:after :nvim-cmp})
                                    (spec :hrsh7th/cmp-buffer
                                          {:after :nvim-cmp})
                                    (spec :hrsh7th/cmp-vsnip {:after :nvim-cmp})
                                    (spec :tzachar/cmp-tabnine
                                          {:run :./install.sh
                                           :after :nvim-cmp
                                           :config #(let [tabnine (require :cmp_tabnine.config)]
                                                      (tabnine:setup {:max_lines 1000
                                                                      :max_num_results 20
                                                                      :sort true}))})
                                    (spec :hrsh7th/cmp-path {:after :nvim-cmp})
                                    (spec :hrsh7th/cmp-nvim-lua
                                          {:after :nvim-cmp})
                                    (spec :hrsh7th/cmp-calc {:after :nvim-cmp})
                                    (spec :f3fora/cmp-spell {:after :nvim-cmp})
                                    (spec :hrsh7th/cmp-emoji {:after :nvim-cmp})]})
                  (plug :hrsh7th/vim-vsnip
                        {:config #(set vim.g.vsnip_snippet_dir
                                       "~/.config/nvim/snippets")})
                  ;; notes
                  (plug :chikamichi/mediawiki.vim)
                  (plug :iamcco/markdown-preview.nvim
                        {:run "cd app && yarn install" :ft :markdown})
                  (plug :kristijanhusak/orgmode.nvim
                        {:ft :org :config #(setup :orgmode)})
                  (plug :vhyrro/neorg
                        {:ft :norg
                         :requires :nvim-lua/plenary.nvim
                         :config #(setup :neorg)})
                  ;; ui
                  (plug :kyazdani42/nvim-web-devicons) ; (plug :mhinz/vim-startify)
                  (plug :akinsho/bufferline.nvim
                        {:config #(setup :bufferline
                                         {:options {:show_close_icon false
                                                    :always_show_bufferline false}})})
                  (plug :famiu/feline.nvim
                        {:after :onedark.nvim :config #(require :statusline)})
                  (plug :kdav5758/TrueZen.nvim)
                  (plug :norcalli/nvim-colorizer.lua
                        {:config #(setup :colorizer)}) ; (plug :xiyaowong/nvim-cursorword)
                  ;; explorer
                  (plug :kyazdani42/nvim-tree.lua
                        {:requires :kyazdani42/nvim-web-devicons
                         :config #(setup :nvim-tree)
                         :cmd :NvimTreeToggle})
                  (plug :kevinhwang91/rnvimr {:cmd :RnvimrToggle})
                  (plug :nvim-telescope/telescope.nvim
                        {:requires [[:nvim-lua/popup.nvim]
                                    [:nvim-lua/plenary.nvim]]
                         :cmd :Telescope})
                  ;; git
                  (plug :lewis6991/gitsigns.nvim
                        {:requires :nvim-lua/plenary.nvim
                         :config #(setup :gitsigns)})
                  ;; utils
                  (plug :ggandor/lightspeed.nvim)
                  (plug :tpope/vim-repeat)
                  (plug :editorconfig/editorconfig-vim)
                  (plug :akinsho/nvim-toggleterm.lua
                        {:cmd :ToggleTerm
                         :config #(setup :toggleterm
                                         {:size 10
                                          :insert_mappings false
                                          :shade_filetypes {}
                                          :shade_terminals true
                                          :shading_factor 1
                                          :start_in_insert true
                                          :persist_size true
                                          :direction :float})})
                  (plug :folke/which-key.nvim {:config #(setup :which-key)})
                  ;; coding
                  (plug :b3nj5m1n/kommentary
                        {:config #(do
                                    (tset vim.g
                                          :kommentary_create_default_mappings
                                          false)
                                    (module-conf :kommentary.config
                                                 :configure_language :default
                                                 {:prefer_single_line_comments true}))})
                  (plug :windwp/nvim-autopairs
                        {:config #(require :pairs) :after :nvim-cmp})
                  (plug :tpope/vim-surround)
                  (plug :godlygeek/tabular)
                  (plug :mizlan/iswap.nvim {:cmd :ISwap})
                  ;; Interactive
                  (plug :metakirby5/codi.vim {:cmd :Codi})
                  ;; lib
                  (plug :6cdh/fulib.nvim)
                  ;; profile
                  (plug :dstein64/vim-startuptime {:cmd :StartupTime})
                  (plug :lewis6991/impatient.nvim)
                  ;; color scheme
                  (plug :ful1e5/onedark.nvim {:config #(require :theme)})))

