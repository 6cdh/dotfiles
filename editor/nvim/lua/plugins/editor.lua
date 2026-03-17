return {
    {
        "ggandor/leap.nvim",
        url = "https://codeberg.org/andyg/leap.nvim",
        cond = function() return true end,
        config = function()
            -- new leap bindings
            vim.keymap.set('n', 's', '<Plug>(leap-forward)')
            vim.keymap.set('n', 'S', '<Plug>(leap-backward)')
        end
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        cond = true,
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        "jiaoshijie/undotree",
        dependencies = "nvim-lua/plenary.nvim",
        config = true,
        keys = {
            { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>", desc = "Toggle UndoTree" },
        },
    },
    {
        "tpope/vim-repeat",
    },
    {
        "echasnovski/mini.align",
        version = false,
        cond = true,
        config = function()
            require('mini.align').setup()
        end
    }
}
