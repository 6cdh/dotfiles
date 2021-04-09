local g = vim.g

g.ale_echo_msg_format = '%s --%linter%'
g.ale_disable_lsp = 1
g.ale_linters_ignore = {cpp = {'clangtidy'}}
g.ale_sign_error = 'X'
g.ale_sign_warning = '!'
