local km = {
    mode = {
        normal = 'n',
        select = 's',
        visual = 'x',
        insert = 'i',
        cmd = 'c',
        terminal = 't',
        operator_pending = 'o',
        insert_cmd = '!',
        insert_cmd_langarg = 'l',
        visual_select = 'v'
    },

    map = vim.api.nvim_set_keymap,
    opts = {noremap = 'noremap', expr = 'expr', silent = 'silent'},
    mk = function(...)
        local arg = {...}
        local t = {}
        for _, v in ipairs(arg) do t[v] = true end
        return t
    end,
    to_keycodes = function(s)
        return vim.api.nvim_replace_termcodes(s, true, true, true)
    end
}

return km
