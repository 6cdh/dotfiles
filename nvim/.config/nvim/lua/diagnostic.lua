local g = vim.g

g.ale_echo_msg_format = '%s --%linter%'
g.ale_disable_lsp = 1
g.ale_linters_ignore = {cpp = {'clangtidy'}}
g.ale_sign_error = ' '
g.ale_sign_warning = ' '

g.ale_set_highlights = 0

vim.api.nvim_command [[:highlight ALEError ctermbg=none cterm=underline]]
vim.api.nvim_command [[:highlight ALEWarning ctermbg=none cterm=underline]]
