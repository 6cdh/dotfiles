(macro spec [name opts]
  (var opts (or opts {}))
  (set opts.name name)
  opts)

(macro t [key]
  `(-> (vim.api.nvim_replace_termcodes ,key true true true)
       (vim.api.nvim_feedkeys :i true)))

(local icons (require :theme.icons))

(fn menu-format [entry vim_item]
  ;; codicon and limit the menu width
  (set vim_item.kind (. icons.codicon vim_item.kind))
  (set vim_item.abbr (vim_item.abbr:sub 1 50))
  (set vim_item.menu (string.format "[%s]"
                                    (match entry.source.name
                                      :buffer icons.buffer
                                      :nvim_lsp icons.lsp
                                      :vsnip icons.codicon.Snippet
                                      :nvim_lua icons.lang.lua
                                      :look icons.dict
                                      :cmdline icons.cmd
                                      _ "")))
  vim_item)

(let [cmp (require :cmp)]
  (cmp.setup {:snippet {:expand #(vim.fn.vsnip#anonymous $1.body)}
              :mapping {:<C-k> (cmp.mapping (cmp.mapping.select_prev_item)
                                            [:i :c])
                        :<C-j> (cmp.mapping (cmp.mapping.select_next_item)
                                            [:i :c])
                        :<TAB> (fn [fallback]
                                 (match (vim.fn.vsnip#jumpable 1)
                                   1 (t "<Plug>(vsnip-jump-next)")
                                   _ ((cmp.mapping.confirm {:select true}) fallback)))}
              :formatting {:format menu-format}
              :sources [(spec :nvim_lsp)
                        (spec :vsnip)
                        (spec :buffer)
                        (spec :path)
                        (spec :look
                              {:keyword_length 4
                               :option {:convert_case true :loud true}})
                        (spec :nvim_lua)]})
  (cmp.setup.cmdline ":" {:sources [(spec :cmdline)]}))

(let [cmp_autopairs (require :nvim-autopairs.completion.cmp)
      cmp (require :cmp)]
  (cmp.event:on :confirm_done (cmp_autopairs.on_confirm_done)))

