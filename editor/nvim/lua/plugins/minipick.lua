return {
    {
        "echasnovski/mini.pick",
        version = false,
        config = function()
            require('mini.pick').setup()
        end,
        keys = {
            { "<leader>ff", "<cmd>Pick files<cr>", desc = "Find Files" },
            { "<leader>fg", "<cmd>Pick grep_live<cr>", desc = "Live Grep" },
            { "<leader>fb", "<cmd>Pick buffers<cr>", desc = "Find Buffers" },
        }
    }
}
