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

    map = function(mode, lhs, rhs, ...)
        local opts = {...}
        local t = {}
        for _, v in ipairs(opts) do t[v] = true end
        vim.api.nvim_set_keymap(mode, lhs, rhs, t)
    end,
    cmd = function(s) return '<Cmd>' .. s .. '<CR>' end,
    to_keycodes = function(s)
        return vim.api.nvim_replace_termcodes(s, true, true, true)
    end
}

return km
