local m = {}

m = {
    "folke/which-key.nvim",
    opts = {}, -- default
    keys = {
        { mode = "n", "<leader>k", "<Cmd>WhichKey<CR>", { noremap = true, silent = true } },
    },
}

return m
