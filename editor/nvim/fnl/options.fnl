(local fl (require :fulib))

(macro bset [opt_g tbl]
  "Batch set"
  `(fl.for-each #(tset ,opt_g $2 $1) ,tbl))

(let [indent 4
      textwidth 90]
  (bset vim.opt {: textwidth
                 ; tab
                 :expandtab true
                 :tabstop indent
                 :shiftwidth indent
                 :softtabstop indent
                 :background "light"
                 :cursorline true
                 ; buffer
                 :splitright true
                 :splitbelow true
                 ; fold
                 :foldmethod "marker"
                 ; wrap
                 :wrap true
                 :linebreak true
                 ; incrementally show the effects of a command
                 :inccommand :nosplit
                 ; lazyredraw for executing a lot of macros
                 :lazyredraw true
                 ; updatetime
                 :updatetime 700
                 ; timeoutlen should not too low or too high
                 :timeoutlen 300
                 ; case insensitive
                 :ignorecase true
                 ; if uppercase used, the search would be case sensitive
                 :smartcase true
                 ; disable mode display
                 :showmode false
                 ; highlight matching brackets when input, very useful for lisp
                 :showmatch true
                 ; highlight time for 'showmatch'
                 :matchtime 2
                 ; don't show line/column number on cmdline
                 :ruler false
                 ; cmdline height
                 :cmdheight 1
                 ; height of complete menu
                 :pumheight 10
                 ; complete
                 :completeopt [:menuone :noselect]
                 ; better regex search
                 :magic true
                 ; backup
                 :backup false
                 :writebackup false
                 :swapfile false
                 ; better undo function
                 :undofile true
                 ;; ui
                 :termguicolors true
                 :guifont "BlexMono Nerd Font:h16"
                 ; relative number
                 :number true
                 :relativenumber true
                 ;
                 :signcolumn :yes
                 ; respect mouse in all modes
                 :mouse :a
                 ;
                 :scrolloff 1
                 :sidescrolloff 5}))

;; netrw
(bset vim.g {:netrw_banner 0 :netrw_winsize 25 :netrw_browse_split 4})

(set vim.g.mapleader " ")
(vim.opt.shortmess:append :cI)

