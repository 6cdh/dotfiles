(import-macros core :core.macros)

(local M {})

;; modules it depends on
(set M.modules
     [])

;; plugins it depends on
(set M.plugins
     [:nvim-treesitter/nvim-treesitter
      :nvim-treesitter/playground
      :p00f/nvim-ts-rainbow])

;; type of `setup` function for runtime type checker against misconfiguration
(set M.setup-type
     (core.types nil))

(fn M.setup []
  (let [ts (require :nvim-treesitter.configs)]
    (ts.setup {:ensure_installed []
               :highlight {:enable true
                           :additional_vim_regex_highlighting false}
               :incremental_selection {:enable true}
               :textobjects {:enable true}
               :rainbow {:enable true
                         :extended_mode true
                         :max_file_lines 10000}})))

M

