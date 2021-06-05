local npairs = require 'nvim-autopairs'
local Rule = require 'nvim-autopairs.rule'

npairs.setup()

npairs.add_rules {
    Rule(' ', ' '):with_pair(function(opts)
        local pair = opts.line:sub(opts.col, opts.col + 1)
        return vim.tbl_contains({'()', '[]', '{}'}, pair)
    end)
}

