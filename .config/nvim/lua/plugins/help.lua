local m = {}

m.setup = function(use)
    use("folke/which-key.nvim")

    m.setup_which_key()
end

m.setup_which_key = function()
    require("which-key").setup()
end

vim.api.nvim_set_keymap("n", "<leader>k", "<Cmd>WhichKey<CR>", { noremap = true, silent = true })

return m
