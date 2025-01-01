require("paq") {
    "savq/paq-nvim",
    "PaterJason/nvim-treesitter-sexp",
    "tpope/vim-repeat",
    "b3nj5m1n/kommentary",
    "tpope/vim-surround",
    "godlygeek/tabular",
    "dstein64/vim-startuptime",
    "catppuccin/nvim",
    "ggandor/leap.nvim",
    "nvim-lualine/lualine.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/playground",
    "neovim/nvim-lspconfig",
    "mbbill/undotree"
}

if vim.g.vscode == nil then
    vim.g.kommentary_create_default_mappings = false
    require("kommentary.config").configure_language(
        "default",
        {
            prefer_single_line_comments = true
        }
    )

    require("catppuccin").setup {
       flavour = "frappe"
    }

    vim.cmd("colorscheme catppuccin")

    require("lualine").setup {
        options = {
            theme = "auto"
        }
    }

    require('lspconfig').racket_langserver.setup {}

    require('nvim-treesitter.configs').setup {
        ensure_installed = {},
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false
        },
        indent = {
            enable = true
        }
    }

    require('leap').add_default_mappings()
else
    require('nvim-treesitter.configs').setup {
        ensure_installed = {},
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = false,
            additional_vim_regex_highlighting = false
        },
        indent = {
            enable = false
        }
    }

    require('leap').add_default_mappings()
end

