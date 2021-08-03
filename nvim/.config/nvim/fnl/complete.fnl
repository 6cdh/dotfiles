(local st {:preselect :always
           :max_abbr_width 45
           :source {:path true
                    :buffer true
                    :spell true
                    :calc true
                    :nvim_lsp true
                    :nvim_lua true
                    :vsnip true
                    :orgmode true
                    :tabnine {:ignore_pattern "[){};]"}}})

(let [compe (require :compe)]
  (compe.setup st))

