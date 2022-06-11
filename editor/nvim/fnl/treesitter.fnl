(let [ts (require :nvim-treesitter.configs)]
  (ts.setup {:ensure_installed []
             :highlight {:enable true
                         :additional_vim_regex_highlighting false}
             :incremental_selection {:enable true}
             :textobjects {:enable true}
             :rainbow {:enable true :extended_mode true}}))

