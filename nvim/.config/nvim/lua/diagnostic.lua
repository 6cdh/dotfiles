local g = vim.g

g.ale_echo_msg_format = '%s --%linter%'
g.ale_disable_lsp = 1
g.ale_linters_ignore = {cpp = {'clangtidy'}}
g.ale_sign_error = ''
g.ale_sign_warning = ''

g.ale_set_highlights = 0

vim.cmd [[:highlight ALEError ctermbg=none cterm=underline]]
vim.cmd [[:highlight ALEWarning ctermbg=none cterm=underline]]
