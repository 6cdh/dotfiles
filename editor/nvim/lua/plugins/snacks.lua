return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      bufdelete = { enabled = true },
    },
    keys = {
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    },
  }
}
