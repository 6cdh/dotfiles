(import-macros core :core.macros)

(local M {})

;; modules it depends on
(set M.modules
     [])

;; plugins it depends on
(set M.plugins
     ["guns/vim-sexp"])

;; type of `setup` function for runtime type checker against misconfiguration
(set M.setup-type
     (core.types nil))

(fn M.setup [pkgs]
  ;; lisp support

  (local ft {:lisp ["lisp" "scheme" "racket" "clojure" "fennel" "janet"]})

  (set vim.g.sexp_filetypes (table.concat ft.lisp ","))
  (set vim.g.sexp_enable_insert_mode_mappings true)
  (set vim.g.sexp_insert_after_wrap true)

  (set vim.g.sexp_mappings 
    {:sexp_outer_list "al"
     :sexp_inner_list "il"
     :sexp_outer_top_list "aL"
     :sexp_inner_top_list "iL"

     :sexp_outer_string "as"
     :sexp_inner_string "is"

     :sexp_outer_element "ae"
     :sexp_inner_element "ie"

     :sexp_move_to_prev_bracket "("
     :sexp_move_to_next_bracket ")"

     :sexp_move_to_prev_element_head "b"
     :sexp_move_to_next_element_head "w"
     :sexp_move_to_prev_element_tail "ge"
     :sexp_move_to_next_element_tail "e"

     :sexp_flow_to_prev_close "<M-]>"
     :sexp_flow_to_next_close "<M-{>"
     :sexp_flow_to_next_open "<M-[>"
     :sexp_flow_to_prev_open "<M-}>"

     :sexp_flow_to_prev_leaf_head "<M-S-b>"
     :sexp_flow_to_next_leaf_head "<M-S-w>"
     :sexp_flow_to_prev_leaf_tail "<M-S-g>"
     :sexp_flow_to_next_leaf_tail "<M-S-e>"

     :sexp_move_to_prev_top_element "[["
     :sexp_move_to_next_top_element "]]"

     :sexp_select_prev_element "[e"
     :sexp_select_next_element "]e"

     :sexp_indent "=="
     :sexp_indent_top "=-"

     :sexp_round_head_wrap_list "<leader>rl("
     :sexp_round_tail_wrap_list "<leader>rl)"
     :sexp_square_head_wrap_list "<leader>rl["
     :sexp_square_tail_wrap_list "<leader>rl]"
     :sexp_curly_head_wrap_list "<leader>rl{"
     :sexp_curly_tail_wrap_list "<leader>rl}"

     :sexp_round_head_wrap_element "<leader>r("
     :sexp_round_tail_wrap_element "<leader>r)"
     :sexp_square_head_wrap_element "<leader>r["
     :sexp_square_tail_wrap_element "<leader>r]"
     :sexp_curly_head_wrap_element "<leader>r{"
     :sexp_curly_tail_wrap_element "<leader>r}"

     :sexp_insert_at_list_head "<leader>ih"
     :sexp_insert_at_list_tail "<leader>it"

     :sexp_splice_list "<leader>j"
     :sexp_convolute "<leader>?"
     :sexp_raise_list "<leader>rf" ; replace parent with current form
     :sexp_raise_element "<leader>re" ; replace parent with current element

     :sexp_swap_list_backward "<leader>mfb" ; move back
     :sexp_swap_list_forward "<leader>mfw" ; move next

     :sexp_swap_element_backward "<leader>mb"
     :sexp_swap_element_forward "<leader>mw"

     :sexp_emit_head_element "<M-S-j>"
     :sexp_emit_tail_element "<M-S-k>"

     :sexp_capture_prev_element "<M-S-h>"
     :sexp_capture_next_element "<M-S-l>"}))

M

