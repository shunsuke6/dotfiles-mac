local m = {}

m.setup = function(use)
    use({
        "akinsho/toggleterm.nvim",
        tag = "v1.*",
    })

    m.setup_toggleterm()
end

m.setup_toggleterm = function()
    require("toggleterm").setup()
end

vim.keymap.set("n", "<M-t>", "<cmd>ToggleTerm<CR>", { silent = true, noremap = true })

return m
