local filetypes = {
    lisp = {
        "lisp",
        "scheme",
        "racket",
        "clojure",
        "fennel",
        "janet"
    }
}

vim.g.sexp_filetypes = table.concat(filetypes.lisp, ",")

if vim.g.vscode ~= nil then
    vim.g.sexp_enable_insert_mode_mappings = false
    vim.g.sexp_insert_after_wrap = false
else
    vim.g.sexp_enable_insert_mode_mappings = true
    vim.g.sexp_insert_after_wrap = true
end

vim.g.sexp_mappings = {
    sexp_outer_list = "al",
    sexp_inner_list = "il",
    sexp_outer_top_list = "aL",
    sexp_inner_top_list = "iL",
    sexp_outer_string = "as",
    sexp_inner_string = "is",
    sexp_outer_element = "ae",
    sexp_inner_element = "ie",
    sexp_move_to_prev_bracket = "(",
    sexp_move_to_next_bracket = ")",
    sexp_move_to_prev_element_head = "b",
    sexp_move_to_next_element_head = "w",
    sexp_move_to_prev_element_tail = "ge",
    sexp_move_to_next_element_tail = "e",
    sexp_flow_to_prev_close = "<M-]>",
    sexp_flow_to_next_close = "<M-{>",
    sexp_flow_to_next_open = "<M-[>",
    sexp_flow_to_prev_open = "<M-}>",
    sexp_flow_to_prev_leaf_head = "<M-S-b>",
    sexp_flow_to_next_leaf_head = "<M-S-w>",
    sexp_flow_to_prev_leaf_tail = "<M-S-g>",
    sexp_flow_to_next_leaf_tail = "<M-S-e>",
    sexp_move_to_prev_top_element = "[[",
    sexp_move_to_next_top_element = "]]",
    sexp_select_prev_element = "[e",
    sexp_select_next_element = "]e",
    sexp_indent = "==",
    sexp_indent_top = "=-",
    sexp_round_head_wrap_list = "<leader>wl(",
    sexp_round_tail_wrap_list = "<leader>wl)",
    sexp_square_head_wrap_list = "<leader>wl[",
    sexp_square_tail_wrap_list = "<leader>wl]",
    sexp_curly_head_wrap_list = "<leader>wl{",
    sexp_curly_tail_wrap_list = "<leader>wl}",
    sexp_round_head_wrap_element = "<leader>w(",
    sexp_round_tail_wrap_element = "<leader>w)",
    sexp_square_head_wrap_element = "<leader>w[",
    sexp_square_tail_wrap_element = "<leader>w]",
    sexp_curly_head_wrap_element = "<leader>w{",
    sexp_curly_tail_wrap_element = "<leader>w}",
    sexp_insert_at_list_head = "<leader>ih",
    sexp_insert_at_list_tail = "<leader>it",
    sexp_splice_list = "<leader>sl",
    sexp_convolute = "<leader>cv",
    sexp_raise_list = "<leader>rl",
    sexp_raise_element = "<leader>re",
    sexp_swap_list_backward = "<leader>slb",
    sexp_swap_list_forward = "<leader>slf",
    sexp_swap_element_backward = "<leader>seb",
    sexp_swap_element_forward = "<leader>sef",
    sexp_emit_head_element = "<leader>ehe",
    sexp_emit_tail_element = "<leader>ete",
    sexp_capture_prev_element = "<leader>cpe",
    sexp_capture_next_element = "<leader>cne"
}
