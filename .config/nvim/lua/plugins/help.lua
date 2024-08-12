local m = {}

m = {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {}, -- default
    -- keys = {
    --     { mode = "n", "<leader>k", "<Cmd>WhichKey<CR>", { noremap = true, silent = true } },
    -- },
 keys = {
    {
      "<leader>k",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}

return m
