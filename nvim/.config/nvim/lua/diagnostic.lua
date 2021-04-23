local g = vim.g
local colors = require 'colors'

g.ale_echo_msg_format = '%s --%linter%'
g.ale_disable_lsp = 1
g.ale_linters_ignore = {cpp = {'clangtidy'}}
g.ale_sign_error = ' '
g.ale_sign_warning = ' '

vim.api.nvim_command(string.format(
                         "autocmd Colorscheme * highlight SpellBad guifg=NONE cterm=undercurl guisp='%s'",
                         colors.red))
vim.api.nvim_command(string.format(
                         "autocmd Colorscheme * highlight SpellCap guifg=NONE cterm=undercurl guisp='%s'",
                         colors.yellow))
