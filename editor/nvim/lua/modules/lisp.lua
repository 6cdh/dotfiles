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

require("treesitter-sexp").setup {
  enabled = true,
  set_cursor = true,
  keymaps = {
    commands = {
      swap_prev_elem = "<leader><e",
      swap_next_elem = "<leader>>e",
      swap_prev_form = "<leader><l",
      swap_next_form = "<leader>>l",
      promote_elem = "<leader>re",
      promote_form = "<leader>rl",
      splice = "<leader>sp",
      slurp_left = "<leader>sl",
      slurp_right = "<leader>sr",
      barf_left = "<leader>bl",
      barf_right = "<leader>br",
      insert_head = "<leader>ih",
      insert_tail = "<leader>it",
    },
    motions = {
      form_start = "(",
      form_end = ")",
      prev_elem = "b",
      next_elem = "w",
      prev_elem_end = "E",
      next_elem_end = "e",
      prev_top_level = "[[",
      next_top_level = "]]",
    },
    textobjects = {
      inner_elem = "ie",
      outer_elem = "ae",
      inner_form = "il",
      outer_form = "al",
      inner_top_level = "itl",
      outer_top_level = "atl",
    }
  }
}

vim.cmd [[nmap <leader>we vie<esc>a()<esc><leader>sl<leader>ih]]
vim.cmd [[nmap <leader>wl val<esc>a()<esc><leader>sl<leader>ih]]

