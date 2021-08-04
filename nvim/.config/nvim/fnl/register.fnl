(local fs (require :fs))
(local vcmd vim.api.nvim_command)

(fn new_augroup [name def]
  (vcmd (.. "augroup " name))
  (vcmd :au!)
  (fs.map #(vcmd (.. "au " $1)) def)
  (vcmd "augroup END"))

(fn new_augroups [defs]
  (fs.map #(new_augroup $2 $1) defs))

(fn literal-s [s]
  (.. "'" s "'"))

(fn do-s [...]
  "... -> str"
  (table.concat [...] " "))

(fn require-s [module]
  "str -> str"
  (.. "require(" (literal-s module) ")"))

(fn require-run-s [module f ...]
  "str -> str -> [a] -> str"
  (.. (require-s module) "[" (literal-s f) "](" (table.concat [...] ",") ")"))

(fn register-luacmd [cmd s]
  "str -> str -> ()"
  (fn build-command [cmd s]
    (table.concat [:silent! :command cmd :lua s] " "))

  (vcmd (build-command cmd s)))

(fn print-s [...]
  (.. "print(" (table.concat [...] ",") ")"))

(register-luacmd :PackerCompile
                 (do-s (require-s :plugins) (require-run-s :packer :compile)))

(register-luacmd :PackerInstall
                 (do-s (require-s :plugins) (require-run-s :packer :install)))

(register-luacmd :PackerStatus
                 (do-s (require-s :plugins) (require-run-s :packer :status)))

(register-luacmd :PackerSync
                 (do-s (require-s :plugins) (require-run-s :packer :sync)))

(register-luacmd :PackerUpdate
                 (do-s (require-s :plugins) (require-run-s :packer :update)))

(register-luacmd :HotpotCompileSel
                 (print-s (require-run-s :hotpot.api.compile :compile-selection)))

(register-luacmd :HotpotCompileBuf
                 (print-s (require-run-s :hotpot.api.compile :compile-buffer 0)))

(new_augroup :fennel_packer ["BufWritePost plugins.fnl PackerCompile"])

