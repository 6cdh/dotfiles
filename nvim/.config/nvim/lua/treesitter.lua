require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        'c', 'cpp', 'json', 'lua', 'toml', 'haskell', 'javascript', 'latex',
        'python', 'go', 'css', 'html', 'bash'
    },
    highlight = {enable = true},
    incremental_selection = {enable = true},
    textobjects = {enable = true},
    rainbow = {enable = true, extended_mode = true}
}
