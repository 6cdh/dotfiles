local g = vim.g

g.neoformat_basic_format_align = 1
g.neoformat_basic_format_retab = 1
g.neoformat_basic_format_trim = 1

g.neoformat_enabled_python = {'black'}
g.neoformat_enabled_haskell = {'ormolu'}

g.shfmt_opt = '-ci'

g.neoformat_enabled_toml = {'prettier'}
g.neoformat_toml_prettier = {
    exe = 'prettier',
    args = {'--stdin-filepath', '"%:p"'},
    stdin = 1
}

g.neoformat_enabled_make = {'makefmt'}
g.neoformat_make_makefmt = {exe = 'unexpand', args = {'-t 2'}, stdin = 1}
