local m = {}

m = {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
    keys = {
        { mode = "n", "<C-t>t", "<cmd>ToggleTerm<CR>", { silent = true, noremap = true } },
    },
}

return m
