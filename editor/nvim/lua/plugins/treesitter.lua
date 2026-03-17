return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        cond = true,
        build = ":TSUpdate",
        config = function()
            local ts = require("nvim-treesitter")
            local in_vscode = vim.g.vscode ~= nil

            ts.setup({
                install_dir = vim.fn.stdpath("data") .. "/site",
                highlight = {
                    enable = not in_vscode,
                },
            })

            local parsers = require("nvim-treesitter.parsers")

            local group = vim.api.nvim_create_augroup("treesitter_main", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                group = group,
                callback = function(args)
                    local ft = vim.bo[args.buf].filetype
                    if ft == "" then
                        return
                    end

                    local lang = vim.treesitter.language.get_lang(ft) or ft
                    if parsers[lang] == nil then
                        return
                    end

                    if not pcall(vim.treesitter.language.inspect, lang) then
                        ts.install({ lang })
                        return
                    end

                    if not in_vscode then
                        pcall(vim.treesitter.start, args.buf, lang)
                    end
                end,
            })
        end,
    },
    {
        "guns/vim-sexp",
        cond = true,
        init = function()
            vim.g.sexp_filetypes = ""
            vim.g.sexp_enable_insert_mode_mappings = 0
        end,
        config = function()
            local group = vim.api.nvim_create_augroup("vim_sexp_mappings", { clear = true })

            local function map(buf, mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, {
                    buffer = buf,
                    desc = desc,
                    remap = true,
                    silent = true,
                })
            end

            vim.api.nvim_create_autocmd("FileType", {
                group = group,
                pattern = { "clojure", "fennel", "lisp", "racket", "scheme" },
                callback = function(args)
                    local buf = args.buf
                    if vim.b[buf].vim_sexp_mapped then
                        return
                    end

                    vim.b[buf].vim_sexp_mapped = true

                    map(buf, { "n", "x", "o" }, "(", "<Plug>(sexp_move_to_prev_bracket)", "Previous form start")
                    map(buf, { "n", "x", "o" }, ")", "<Plug>(sexp_move_to_next_bracket)", "Next form end")
                    map(buf, { "n", "x", "o" }, "b", "<Plug>(sexp_move_to_prev_element_head)", "Previous element")
                    map(buf, { "n", "x", "o" }, "w", "<Plug>(sexp_move_to_next_element_head)", "Next element")
                    map(buf, { "n", "x", "o" }, "E", "<Plug>(sexp_move_to_prev_element_tail)", "Previous element end")
                    map(buf, { "n", "x", "o" }, "e", "<Plug>(sexp_move_to_next_element_tail)", "Next element end")
                    map(buf, { "n", "x", "o" }, "[[", "<Plug>(sexp_move_to_prev_top_element)", "Previous top level form")
                    map(buf, { "n", "x", "o" }, "]]", "<Plug>(sexp_move_to_next_top_element)", "Next top level form")

                    map(buf, { "x", "o" }, "ie", "<Plug>(sexp_inner_element)", "Inner element")
                    map(buf, { "x", "o" }, "ae", "<Plug>(sexp_outer_element)", "Outer element")
                    map(buf, { "x", "o" }, "il", "<Plug>(sexp_inner_list)", "Inner form")
                    map(buf, { "x", "o" }, "al", "<Plug>(sexp_outer_list)", "Outer form")
                    map(buf, { "x", "o" }, "itl", "<Plug>(sexp_inner_top_list)", "Inner top level form")
                    map(buf, { "x", "o" }, "atl", "<Plug>(sexp_outer_top_list)", "Outer top level form")

                    map(buf, "n", "<leader><e", "<Plug>(sexp_swap_element_backward)", "Swap previous element")
                    map(buf, "n", "<leader>>e", "<Plug>(sexp_swap_element_forward)", "Swap next element")
                    map(buf, "n", "<leader><l", "<Plug>(sexp_swap_list_backward)", "Swap previous form")
                    map(buf, "n", "<leader>>l", "<Plug>(sexp_swap_list_forward)", "Swap next form")
                    map(buf, "n", "<leader>re", "<Plug>(sexp_raise_element)", "Raise element")
                    map(buf, "n", "<leader>rl", "<Plug>(sexp_raise_list)", "Raise form")
                    map(buf, "n", "<leader>sp", "<Plug>(sexp_splice_list)", "Splice form")
                    map(buf, "n", "<leader>sl", "<Plug>(sexp_capture_prev_element)", "Slurp left")
                    map(buf, "n", "<leader>sr", "<Plug>(sexp_capture_next_element)", "Slurp right")
                    map(buf, "n", "<leader>bl", "<Plug>(sexp_emit_head_element)", "Barf left")
                    map(buf, "n", "<leader>br", "<Plug>(sexp_emit_tail_element)", "Barf right")
                    map(buf, "n", "<leader>ih", "<Plug>(sexp_insert_at_list_head)", "Insert at form head")
                    map(buf, "n", "<leader>it", "<Plug>(sexp_insert_at_list_tail)", "Insert at form tail")
                    map(buf, "n", "<leader>we", "<Plug>(sexp_round_head_wrap_element)", "Wrap element")
                    map(buf, "n", "<leader>wl", "<Plug>(sexp_round_head_wrap_list)", "Wrap form")
                end,
            })
        end,
    },
}
