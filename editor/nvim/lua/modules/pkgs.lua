require("paq") {
    "savq/paq-nvim",
    "guns/vim-sexp",
    "tpope/vim-repeat",
    "b3nj5m1n/kommentary",
    "tpope/vim-surround",
    "godlygeek/tabular",
    "dstein64/vim-startuptime",
    "olimorris/onedarkpro.nvim",
    "https://github.com/ggandor/leap.nvim"
}

if vim.g.vscode == nil then
    vim.g.kommentary_create_default_mappings = false
    require("kommentary.config").configure_language(
        "default",
        {
            prefer_single_line_comments = true
        }
    )

    require("onedarkpro").setup {
        highlights = {
            Identifier = {
                fg = "${black}"
            }
        },
        options = {
            cursorline = true,
            bold = true,
            italic = true,
            underline = true,
            undercurl = true
        }
    }
    vim.cmd("colorscheme onelight")
end

require('leap').add_default_mappings()

