(local fs (require :fs))

(local cmd vim.api.nvim_command)

(local _M {})

(fn _M.new_augroup [defs]
  (each [name def (pairs defs)]
    (do
      (cmd (.. "augroup " name))
      (cmd :au!)
      (fs.map #(cmd (.. "au " $1)) def)
      (cmd "augroup END"))))

(fn _M.to_keycodes [s]
  (vim.api.nvim_replace_termcodes s true true true))

_M

