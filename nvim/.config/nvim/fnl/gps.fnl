(local {: codicon} (require :theme.icons))

(fn call [f ...]
  (f ...))

(-> (require :nvim-gps) (. :setup)
    (call {:icons {:class-name codicon.Class
                   :function-name codicon.Function
                   :method-name codicon.Method}}))

