; (import-macros fl :fl.macros)
(let [fl (require :fulib)
      icons (require :theme.icons)
      signs {:Error icons.errs
             :Warning icons.warns
             :Hint icons.hints
             :Information icons.infos}]
  (fl.map #(let [hl (.. :LspDiagnosticsSign $2)]
             (vim.fn.sign_define hl {:text $1 :texthl hl :numhl ""}))
          signs))

(tset vim.lsp.handlers :textDocument/publishDiagnostics
      (vim.lsp.with vim.lsp.diagnostic.on_publish_diagnostics
                    {:signs true
                     :underline true
                     :virtual_text false
                     :update_in_insert false}))

