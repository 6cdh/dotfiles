(let [fl (require :fulib)
      icons (require :theme.icons)
      signs {:Error icons.errs
             :Warn icons.warns
             :Hint icons.hints
             :Info icons.infos}]
  (fl.map #(let [hl (.. :DiagnosticSign $2)]
             (vim.fn.sign_define hl {:text $1 :texthl hl :numhl ""}))
          signs))

(vim.diagnostic.config {:virtual_text false
                        :signs true
                        :underline true
                        :update_in_insert false
                        :severity_sort false})

