local _M = {}

local cmd = vim.cmd

function _M.new_augroup(defs)
    for name, def in pairs(defs) do
        cmd('augroup ' .. name)
        cmd 'au!'
        for _, statement in ipairs(def) do cmd('au ' .. statement) end
        cmd 'augroup END'
    end
end

return _M
