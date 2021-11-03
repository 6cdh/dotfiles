(local fl (require :fulib))
(local vcmd vim.api.nvim_command)

(fn new_augroup [name defs]
  (vcmd (string.format "augroup %s" name))
  (vcmd :au!)
  (fl.map #(vcmd (string.format "au %s" $1)) defs)
  (vcmd "augroup END"))

(fn new_augroups [defs]
  (fl.map #(new_augroup $2 $1) defs))

(local vim-event {:BufWritePost :BufWritePost})

(macro register-luacmd [cmd expression]
  `(vim.api.nvim_command ,(string.format ":silent! :command %s :Fnl %s" cmd
                                         (view expression))))

(global luacmd-util {:eval (fn [f ...]
                             (f ...))})

(register-luacmd :HotpotCompileSel
                 (-> (require :hotpot.api.compile)
                     (. :compile-selection)
                     (luacmd-util.eval)
                     (print)))

(register-luacmd :HotpotCompileBuf
                 (-> (require :hotpot.api.compile)
                     (. :compile-buffer)
                     (luacmd-util.eval 0)
                     (print)))

(register-luacmd :SudoWrite
                 (let [passwd (vim.fn.inputsecret "[sudo] password: ")
                       tmp_file :/tmp/vim_sudo]
                   (-> "silent! w !tee %s && echo \"%s\" | sudo -S cp %s %% >/dev/null"
                       (string.format tmp_file passwd tmp_file)
                       (vim.api.nvim_command))
                   (vim.api.nvim_command :edit!)))

(new_augroup :packer_autocompile
             [(table.concat [vim-event.BufWritePost
                             :plugins.fnl
                             :PackerCompile] " ")])

