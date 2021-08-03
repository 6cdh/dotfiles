(local fs (require :fs))

(local _M {})

(local vcmd vim.api.nvim_command)

(fn _M.new_augroup [name def]
  (vcmd (.. "augroup " name))
  (vcmd :au!)
  (fs.map #(vcmd (.. "au " $1)) def)
  (vcmd "augroup END"))

(fn _M.new_augroups [defs]
  (fs.map #(_M.new_augroup $2 $1) defs))

(fn _M.to_keycodes [s]
  (vim.api.nvim_replace_termcodes s true true true))

(fn call [f ...]
  (f ...))

(fn _M.require-call [m f ...]
  ((. (require m) f) ...))

(fn _M.require-call-str [m f ...]
  (fn build-arguments [...]
    (table.concat [...] ","))

  (string.format "require'%s'.%s(%s)" m f (build-arguments ...)))

(fn _M.register-luacmd [cmd f]
  (fn build-command [cmd f]
    (match (type f)
      :string (table.concat [:silent! :command cmd :lua f] " ")
      :function (table.concat [:silent! :command cmd :lua (f)] " ")
      _ (error (.. "register-luacmd: Expect string or function, Got " (type f)))))

  (vcmd (build-command cmd f)))

_M

