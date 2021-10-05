(macro call [f ...]
  `(,f ,...))

(macro t [key]
  `(-> (vim.api.nvim_replace_termcodes ,key true true true)
       (vim.api.nvim_feedkeys :i true)))

(let [cmp (require :cmp)
      {: codicon} (require :theme.icons)]
  (cmp.setup {:snippet {:expand (fn [args]
                                  (vim.fn.vsnip#anonymous args.body))}
              :mapping {:<C-k> (cmp.mapping.select_prev_item)
                        :<C-j> (cmp.mapping.select_next_item)
                        :<TAB> (fn [fallback]
                                 (if (= (vim.fn.vsnip#jumpable 1) 1)
                                     (t "<Plug>(vsnip-jump-next)")
                                     (-> (cmp.mapping.confirm {:select true})
                                         (call fallback))))}
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

