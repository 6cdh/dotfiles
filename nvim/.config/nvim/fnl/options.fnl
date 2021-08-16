(local fl (require :fulib))

(local opt vim.opt)

(macro bset [tbl]
  "Batch set"
  `(fl.for_each #(tset opt $2 $1) ,tbl))

(let [indent 4
      textwidth 90]
  (bset {: textwidth
         :expandtab true
         :tabstop indent
         :shiftwidth indent
         :softtabstop indent
         :inccommand :nosplit
         :lazyredraw true
         :breakindent true
         :smartindent true
         :updatetime 250
         :timeoutlen 300
         :smartcase true
         :ignorecase true
         :showmode false
         :ruler false
         :cmdheight 1
         :pumheight 10
         :completeopt [:menuone :noselect]
         :magic true
         :backup false
         :writebackup false
         :swapfile false
         :termguicolors true
         :number true
         :relativenumber true
         :cursorline true
         :signcolumn :yes
         :mouse :a}))

(set vim.g.mapleader " ")
(set vim.g.python3_host_prog "~/.pyenv/versions/nvim/bin/python3")
(opt.shortmess:append :cI)

(let [disabled_builtins [:netrw
                         :netrwPlugin
                         :netrwSettings
                         :netrwFileHandlers
                         :gzip
                         :zip
                         :zipPlugin
                         :tar
                         :tarPlugin]]
  (fl.for_each #(tset vim.g (.. :loaded_ $1) 1) disabled_builtins))

