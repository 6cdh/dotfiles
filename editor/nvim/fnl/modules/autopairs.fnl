(import-macros core :core.macros)

(local M {})

;; modules it depends on
(set M.modules
     [])

;; plugins it depends on
(set M.plugins
     [:windwp/nvim-autopairs])

;; type of `setup` function for runtime type checker against misconfiguration
(set M.setup-type
     (core.types nil))

(fn M.setup [pkgs]
  (let [npairs (require :nvim-autopairs)]
    (npairs.setup {:map_cr true})))

M

