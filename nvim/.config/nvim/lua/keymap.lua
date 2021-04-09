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

    -- map options example
    map = vim.api.nvim_set_keymap,
    noremap = {noremap = true}
}

return km
