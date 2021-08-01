(local fs (require :fs))

(local opt vim.opt)

(fn bset [tbl]
  "Batch set"
  (fs.map2 #(tset opt $2 $1) tbl))

(set vim.g.mapleader " ")

(local indent 4)
(local textwidth 90)

(bset {: textwidth
       :expandtab true
       :tabstop indent
       :shiftwidth indent
       :softtabstop indent
       :inccommand :nosplit
       :lazyredraw true
       :breakindent true
       :updatetime 200
       :timeoutlen 300
       :smartcase true
       :ignorecase true
       :showmode false
       :cmdheight 2
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
       :signcolumn :yes})

(opt.shortmess:append :c)

(set vim.g.python3_host_prog "~/.pyenv/versions/nvim/bin/python3")

