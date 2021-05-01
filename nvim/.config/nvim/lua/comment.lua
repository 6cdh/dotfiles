local km = require 'keymap'

require'nvim_comment'.setup {create_mappings = false}

km.map(km.mode.normal, '<leader>nc', km.cmd('CommentToggle'), 'noremap')
km.map(km.mode.visual, '<leader>nc', ':CommentToggle<CR>', 'noremap', 'silent')

local utils = require 'utils'

utils.new_augroup {
    commentstring_ft = {
        [[FileType c,cpp setlocal commentstring=//%s]]
    }
}

