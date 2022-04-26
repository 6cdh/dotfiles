(local fl (require :fulib))
(local cmd vim.api.nvim_command)


(macro register-fnlcmd [cmd expression]
  `(vim.api.nvim_command ,(string.format ":silent! :command %s :Fnl %s" cmd
                                         (view expression))))

(global fnlcmd-utils {:call (fn [f ...]
                              (f ...))})

(register-fnlcmd :HotpotCompileSel
                 (-> (require :hotpot.api.compile)
                     (. :compile-selection)
                     (fnlcmd-utils.call)
                     (print)))

(register-fnlcmd :HotpotCompileBuf
                 (-> (require :hotpot.api.compile)
                     (. :compile-buffer)
                     (fnlcmd-utils.call 0)
                     (print)))

(register-fnlcmd :SudoWrite
                 (let [passwd (vim.fn.inputsecret "[sudo] password: ")
                       tmp_file (vim.fn.tempname)]
                   (-> "silent! w !tee %s && echo \"%s\" | sudo -S cp %s %% >/dev/null"
                       (string.format tmp_file passwd tmp_file)
                       (vim.api.nvim_command))
                   (vim.api.nvim_command :edit!)
                   (vim.fn.delete tmp_file)))

; for lisp
(register-fnlcmd :TogglePair (let [m (require :nvim-autopairs)]
                               (if m.state.disabled
                                   (m.enable)
                                   (m.disable))))

(register-fnlcmd :RemoveTrailingspace
  (vim.api.nvim_command ":%s/\\s\\+$//e"))

(fn new_augroup [name events files actions]
  (local defs [(table.concat [(table.concat events ",")
                              (table.concat files ",")
                              actions]
                             " ")])
  (cmd (string.format "augroup %s" name))
  (cmd :au!)
  (fl.map #(cmd (string.format "au %s" $1)) defs)
  (cmd "augroup END"))

(fn new_augroups [defs]
  (fl.map #(new_augroup $2 $1) defs))

(local vim-event {:BufWritePost :BufWritePost
                  :BufWritePre :BufWritePre
                  :BufRead :BufRead
                  :BufNewFile :BufNewFile})

(new_augroup :scmindent
  [vim-event.BufRead vim-event.BufNewFile]
  [:*.lisp :*.scm]
  "setlocal equalprg=scmindent.lisp")

(new_augroup :packer_autocompile
  [vim-event.BufWritePost]
  [:plugins.fnl]
  :PackerCompile)

