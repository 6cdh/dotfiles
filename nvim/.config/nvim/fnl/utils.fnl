(local fs (require :fs))

(local vcmd vim.api.nvim_command)

(local _M {})

(fn _M.to_keycodes [s]
  (vim.api.nvim_replace_termcodes s true true true))

_M

