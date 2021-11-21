(local fl (require :fulib))

(macro bset [tbl opt_g]
  "Batch set"
  `(fl.for_each #(tset ,opt_g $2 $1) ,tbl))

(let [indent 4
      textwidth 90]
  (bset {: textwidth
         :expandtab true
         :tabstop indent
         :shiftwidth indent
         :softtabstop indent
         :wrap false
         :inccommand :nosplit
         :lazyredraw true
         :updatetime 700
         :timeoutlen 300
         :smartcase true
         :ignorecase true
         :showmode false
         :showmatch true
         ; for lisp
         :matchtime 2
         :ruler false
         :cmdheight 1
         :pumheight 10
         :completeopt [:menuone :noselect]
         :magic true
         :backup false
         :writebackup false
         :swapfile false
         :undofile true
         :termguicolors true
         :number true
         :relativenumber true
         :cursorline true
         :signcolumn :yes
         :mouse :a
         :scrolloff 1
         :sidescrolloff 5
         :confirm true} vim.opt))

;; netrw
(bset {:netrw_banner 0 :netrw_winsize 25 :netrw_browse_split 4} vim.g)

(set vim.g.mapleader " ")
(vim.opt.shortmess:append :cI)

