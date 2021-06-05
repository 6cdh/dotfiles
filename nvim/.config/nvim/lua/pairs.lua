local npairs = require 'nvim-autopairs'
local Rule = require 'nvim-autopairs.rule'

npairs.setup()

-- LuaFormatter off

npairs.add_rules {
    Rule(' ', ' ')
        :with_pair(function(opts)
            local pair = opts.line:sub(opts.col, opts.col + 1)
            return vim.tbl_contains({'()', '[]', '{}'}, pair)
        end),
    Rule('( ', ' )')
        :with_pair(function() return false end)
        :with_move(function() return true end)
        :use_key(')')
}

-- LuaFormatter on
