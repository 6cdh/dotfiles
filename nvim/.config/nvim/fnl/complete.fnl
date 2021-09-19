; (let [compe (require :compe)]
;   (compe.setup {:preselect :always
;                 :max_abbr_width 45
;                 :source {:path true
;                          :buffer true
;                          :spell true
;                          :calc true
;                          :nvim_lsp true
;                          :nvim_lua true
;                          :vsnip true
;                          :orgmode true
;                          :tabnine {:ignore_pattern "[){};]"}}}))

(macro enable_source [names]
  (icollect [_ name (ipairs names)]
    {: name}))

(let [cmp (require :cmp)
      {: codicon} (require :theme.icons)]
  (cmp.setup {:snippet {:expand (fn [args]
                                  (vim.fn.vsnip#anonymous args.body))}
              :mapping {:<C-k> (cmp.mapping.select_prev_item)
                        :<C-j> (cmp.mapping.select_next_item)
                        :<TAB> (cmp.mapping.confirm {:select true})}
              :formatting {:format (fn [entry vim_item]
                                     ;; codicon and limit the menu width
                                     (set vim_item.kind
                                          (. codicon vim_item.kind))
                                     (set vim_item.abbr
                                          (vim_item.abbr:sub 1 50))
                                     (set vim_item.menu
                                          (. {:buffer "[buffer]"
                                              :nvim_lsp "[lsp]"
                                              :vsnip "[snippet]"
                                              :nvim_lua "[lua]"
                                              :cmp_tabnine "[tabnine]"}
                                             entry.source.name))
                                     vim_item)}
              :sources [{:name :cmp_tabnine}
                        {:name :nvim_lsp}
                        {:name :vsnip}
                        {:name :buffer}
                        {:name :path}
                        {:name :nvim_lua}
                        {:name :calc}
                        {:name :spell}]}))

