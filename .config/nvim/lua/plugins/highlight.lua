local m = {}

m.setup = function(use)
    use("norcalli/nvim-colorizer.lua")
    use({
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
    })
    use("myusuf3/numbers.vim")
    use("lukas-reineke/indent-blankline.nvim")

    m.setup_colorizer()
    m.setup_todo_comments()
    m.setup_indent_blankline()
end

m.setup_colorizer = function()
    require("colorizer").setup()
end

m.setup_todo_comments = function()
    require("todo-comments").setup()
end

m.setup_indent_blankline = function()
    require("indent_blankline").setup({
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = false,
    })
end

vim.api.nvim_set_keymap("n", "<Leader>xz", "<cmd>TodoTrouble<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>fz", "<cmd>TodoTelescope<CR>", { noremap = true })

return m
