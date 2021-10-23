(let [npairs (require :nvim-autopairs)
      Rule (require :nvim-autopairs.rule)]
  (npairs.setup))

(macro call [f ...]
  `(,f ,...))

(-> (require :nvim-autopairs.completion.cmp)
    (. :setup)
    (call {:map_cr true :map_complete true :insert false}))
