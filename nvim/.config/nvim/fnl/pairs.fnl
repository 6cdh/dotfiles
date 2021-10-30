(let [npairs (require :nvim-autopairs)]
  (npairs.setup {:map_cr true}))

(let [cmp_autopairs (require :nvim-autopairs.completion.cmp)
      cmp (require :cmp)]
  (cmp.event:on :confirm_done (cmp_autopairs.on_confirm_done)))

