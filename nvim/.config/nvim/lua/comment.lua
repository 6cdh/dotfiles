require'nvim_comment'.setup {create_mappings = false}

local utils = require 'utils'

utils.new_augroup {
    commentstring_ft = {[[FileType c,cpp setlocal commentstring=//%s]]}
}

