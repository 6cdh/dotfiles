(local packer (require :packer))

(macro spec [name tbl]
  (local tbl (or tbl {}))
  (tset tbl 1 name)
  tbl)

(macro plug [name tbl]
  `(use (spec ,name ,tbl)))

(macro call [f ...]
  `(,f ,...))

(macro module-do [m f ...]
  `(-> (require ,m) (. ,f) (call ,...)))

(macro setup [m ...]
  `(module-do ,m :setup ,...))

(packer.startup (fn [use]
                  (plug :wbthomason/packer.nvim)
                  (plug :rktjmp/hotpot.nvim)
                  (plug :guns/vim-sexp)
                  ;; lsp
                  (plug :nvim-treesitter/nvim-treesitter
                        {:config #(require :treesitter)})
                  (plug :nvim-treesitter/playground {:cmd :TSPlaygroundToggle})
                  (plug :neovim/nvim-lspconfig)
                  (plug :ray-x/lsp_signature.nvim
                        {:config #(setup :lsp_signature {:hint_enable false})})
                  (plug :folke/trouble.nvim
                        {:cmd :Trouble :config #(setup :trouble)})
                  (plug :folke/todo-comments.nvim
                        {:requires :nvim-lua/plenary.nvim
                         :config #(setup :todo-comments)})
                  (plug :j-hui/fidget.nvim
                        {:config #(setup :fidget)})
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
                                                                      :max_num_results 2
                                                                      :sort true
                                                                      :run_on_every_keystroke true}))})
                                    (spec :hrsh7th/cmp-path {:after :nvim-cmp})
                                    (spec :hrsh7th/cmp-nvim-lua
                                          {:after :nvim-cmp})
                                    (spec :octaltree/cmp-look
                                          {:after :nvim-cmp})
                                    (spec :f3fora/cmp-spell {:after :nvim-cmp})
                                    (spec :hrsh7th/cmp-cmdline
                                          {:after :nvim-cmp})]})
                  (plug :hrsh7th/vim-vsnip
                        {:config #(set vim.g.vsnip_snippet_dir
                                       "~/.config/nvim/snippets")})
                  ;; notes
                  (plug :chikamichi/mediawiki.vim)
                  (plug :iamcco/markdown-preview.nvim
                        {:run "cd app && yarn install" :ft :markdown})
                  (plug :kristijanhusak/orgmode.nvim
                        {:ft :org :config #(setup :orgmode)})
                  (plug :nvim-neorg/neorg
                        {:ft :norg
                         :after "nvim-treesitter"
                         :requires :nvim-lua/plenary.nvim
                         :config #(setup :neorg)})
                  ;; ui
                  (plug :rcarriga/nvim-notify)
                  (plug :kyazdani42/nvim-web-devicons)
                  (plug :akinsho/bufferline.nvim
                        {:config #(setup :bufferline
                                         {:options {:show_close_icon false
                                                    :always_show_bufferline false}})})
                  (plug :feline-nvim/feline.nvim
                        {:config #(require :statusline)})
                  (plug :kdav5758/TrueZen.nvim)
                  (plug :norcalli/nvim-colorizer.lua
                        {:config #(setup :colorizer)})
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
                  (plug :s1n7ax/nvim-comment-frame {:config #(setup "nvim-comment-frame")})
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

                  (plug :b3nj5m1n/kommentary
                        {:config #(do
                                    (tset vim.g
                                          :kommentary_create_default_mappings
                                          false)
                                    (module-do :kommentary.config
                                                 :configure_language :default
                                                 {:prefer_single_line_comments true}))})
                  (plug :windwp/nvim-autopairs {:config #(require :pairs)})
                  (plug :tpope/vim-surround)
                  (plug :godlygeek/tabular)
                  (plug :mizlan/iswap.nvim {:cmd :ISwap})
                  ;; Interactive
                  (plug :metakirby5/codi.vim {:cmd :Codi})
                  ; (plug :Olical/conjure {:ft [:fennel :scheme :clojure :racket :lisp]
                  ;                        :config
                  ;                        #(do (set vim.g.conjure#client#scheme#stdio#command :petite)
                  ;                             (set vim.g.conjure#client#scheme#stdio#prompt_pattern "> $?")
                  ;                             (set vim.g.conjure#client#scheme#stdio#value_prefix_pattern false)
                  ;                             (set vim.g.conjure#filetype#fennel "conjure.client.fennel.stdio")
                  ;                             (set vim.g.conjure#mapping#prefix " tn")
                  ;                             (set vim.g.conjure#log#hud#enabled false))})
                  ;; lang
                  (plug :gpanders/nvim-parinfer)
                  ;; lib
                  (plug :6cdh/fulib.nvim)
                  ;; profile
                  (plug :dstein64/vim-startuptime {:cmd :StartupTime})
                  ;; color scheme
                  (plug :catppuccin/nvim 
                    {:as "catppuccin-nvim"
                     :config #(do (setup "catppuccin"
                                    {:integrations {:which_key true}})
                                  (set vim.g.catppuccin_flavour "latte")
                                  (vim.cmd "colorscheme catppuccin"))})))
                  ; (plug :olimorris/onedarkpro.nvim
                  ;         {:config #(do (setup :onedarkpro
                  ;                         {:options
                  ;                            {:cursorline true
                  ;                             :bold true
                  ;                             :italic true
                  ;                             :bold_italic true
                  ;                             :underline true
                  ;                             :undercurl true}
                  ;                          :styles
                  ;                           {:comments "italic"
                  ;                            :keywords "italic"}})
                  ;                       (module-do :onedarkpro :load))})))

