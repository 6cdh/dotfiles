(macro call [f ...]
  `(,f ,...))

(macro module-do [m f ...]
  `(-> (require ,m) (. ,f) (call ,...)))

(macro setup [m ...]
  `(module-do ,m :setup ,...))

[{1 :wbthomason/packer.nvim}
 {1 :rktjmp/hotpot.nvim}
 {1 :guns/vim-sexp}
;; lsp
 {1 :nvim-treesitter/nvim-treesitter
  :config #(require :treesitter)}
 {1 :nvim-treesitter/playground
  :cmd :TSPlaygroundToggle}
 {1 :neovim/nvim-lspconfig}
 {1 :ray-x/lsp_signature.nvim
  :config #(setup :lsp_signature {:hint_enable false})}
 {1 :folke/trouble.nvim
  :cmd :Trouble
  :config #(setup :trouble)}
 {1 :folke/todo-comments.nvim
  :requires :nvim-lua/plenary.nvim
  :config #(setup :todo-comments)}
 {1 :j-hui/fidget.nvim
  :config #(setup :fidget)}
;; dap
 {1 :mfussenegger/nvim-dap}
;; completion
 {1 :hrsh7th/nvim-cmp
  :event :InsertEnter
  :config #(require :complete)}
 {1 :hrsh7th/cmp-nvim-lsp
  :after :nvim-cmp}
 {1 :hrsh7th/cmp-buffer
  :after :nvim-cmp}
 {1 :hrsh7th/cmp-vsnip
  :after :nvim-cmp}
 {1 :tzachar/cmp-tabnine
  :run :./install.sh
  :after :nvim-cmp
  :config #(let [tabnine (require :cmp_tabnine.config)]
             (tabnine:setup {:max_lines 1000
                             :max_num_results 2
                             :sort true
                             :run_on_every_keystroke true}))}
 {1 :hrsh7th/cmp-path
  :after :nvim-cmp}
 {1 :hrsh7th/cmp-nvim-lua
  :after :nvim-cmp}
 {1 :octaltree/cmp-look
  :after :nvim-cmp}
 {1 :f3fora/cmp-spell
  :after :nvim-cmp}
 {1 :hrsh7th/cmp-cmdline
  :after :nvim-cmp}
 {1 :hrsh7th/vim-vsnip
  :config #(set vim.g.vsnip_snippet_dir "~/.config/nvim/snippets")}
;; notes
 {1 :chikamichi/mediawiki.vim}
 {1 :iamcco/markdown-preview.nvim
  :run "cd app && yarn install"
  :ft :markdown}
 {1 :kristijanhusak/orgmode.nvim
  :ft :org
  :config #(setup :orgmode)}
 {1 :nvim-neorg/neorg
  :ft :norg
  :after "nvim-treesitter"
  :requires :nvim-lua/plenary.nvim
  :config #(setup :neorg)}
  ;; ui
 {1 :rcarriga/nvim-notify}
 {1 :kyazdani42/nvim-web-devicons}
 {1 :akinsho/bufferline.nvim
  :config #(setup :bufferline
                  {:options {:show_close_icon false
                             :always_show_bufferline false}})}
 {1 :feline-nvim/feline.nvim
  :config #(require :statusline)}
 {1 :kdav5758/TrueZen.nvim}
 {1 :norcalli/nvim-colorizer.lua
  :config #(setup :colorizer)}
 {1 :kevinhwang91/rnvimr
  :cmd :RnvimrToggle}
 {1 :nvim-telescope/telescope.nvim
  :cmd :Telescope}
 {1 :nvim-lua/popup.nvim}
 {1 :nvim-lua/plenary.nvim}
;; git
 {1 :lewis6991/gitsigns.nvim
  :config #(setup :gitsigns)}
;; utils
 {1 :s1n7ax/nvim-comment-frame
  :config #(setup "nvim-comment-frame")}
 {1 :ggandor/lightspeed.nvim}
 {1 :tpope/vim-repeat}
 {1 :editorconfig/editorconfig-vim}
 {1 :akinsho/nvim-toggleterm.lua
  :cmd :ToggleTerm
  :config #(setup :toggleterm
                  {:size 10
                   :insert_mappings false
                   :shade_filetypes {}
                   :shade_terminals true
                   :shading_factor 1
                   :start_in_insert true
                   :persist_size true
                   :direction :float})}
 {1 :folke/which-key.nvim
  :config #(setup :which-key)}

 {1 :b3nj5m1n/kommentary
  :config #(do
            (tset vim.g
                  :kommentary_create_default_mappings
                  false)
            (module-do :kommentary.config
                       :configure_language :default
                       {:prefer_single_line_comments true}))}
 {1 :windwp/nvim-autopairs
  :config #(require :pairs)}
 {1 :tpope/vim-surround}
 {1 :godlygeek/tabular}
 {1 :mizlan/iswap.nvim
  :cmd :ISwap}
;; Interactive
 {1 :metakirby5/codi.vim
  :cmd :Codi}
;; lang
 {1 :gpanders/nvim-parinfer}
;; lib
 {1 :6cdh/fulib.nvim}
;; profile
 {1 :dstein64/vim-startuptime
  :cmd :StartupTime}
;; color scheme
 {1 :olimorris/onedarkpro.nvim
  :config #(do
             (setup :onedarkpro
                    {:options
                       {:cursorline true
                        :bold true
                        :italic true
                        :underline true
                        :undercurl true}})
             (vim.cmd "colorscheme onedarkpro"))}]

