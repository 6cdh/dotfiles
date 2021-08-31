(let [ts (require :nvim-treesitter.configs)]
  (ts.setup {:ensure_installed :all
             :highlight {:enable true}
             :incremental_selection {:enable true}
             :textobjects {:enable true}
             :rainbow {:enable true :extended_mode true}}))

