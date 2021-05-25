local _M = {}

local cmd = vim.api.nvim_command

function _M.new_augroup(defs)
    for name, def in pairs(defs) do
        cmd('augroup ' .. name)
        cmd 'au!'
        for _, statement in ipairs(def) do cmd('au ' .. statement) end
        cmd 'augroup END'
    end
end

function _M.to_keycodes(s)
    return vim.api.nvim_replace_termcodes(s, true, true, true)
end

return _M
