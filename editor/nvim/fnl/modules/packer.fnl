(import-macros core :core.macros)

(local M {})

;; modules it depends on
(set M.modules
     [])

;; plugins it depends on
(set M.plugins
     [:wbthomason/packer.nvim])

;; type of `setup` function for runtime type checker against misconfiguration
(set M.setup-type
     (core.types
       (array 
         (or string 
             (table 
               {1 string
                :config function
                :cmd string
                :run string
                :ft string
                :requires string})))))

(fn M.setup [pkgs]
  (let [packer (require "packer")]
    (packer.startup
      (fn [use]
        (each [_ pkg (ipairs pkgs)]
          (use pkg))))))

M

