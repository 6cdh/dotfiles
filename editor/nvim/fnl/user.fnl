(local core (require "core"))

(core.setup
  {:package-manager "modules.packer"
   :packages "pkgs"
   :mods ["options"
          "lisp"
          "treesitter"
          "autopairs"
          "statusline"]})

(let [modules ["register"
               "keymap"
               "diagnostic"
               "lsp"]]
  (each [_ m (ipairs modules)]
    (require m)))
