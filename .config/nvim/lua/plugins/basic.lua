local m = {}

m.setup = function(use)
    use("phaazon/hop.nvim")
    use("unblevable/quick-scope")
    use("bkad/CamelCaseMotion")
    use("machakann/vim-sandwich")
    use("numToStr/Comment.nvim")

    if not vim.g.vscode then
        use({
            "AckslD/nvim-neoclip.lua",
            requires = {
                { "tami5/sqlite.lua", module = "sqlite" },
                { "nvim-telescope/telescope.nvim" },
            },
        })
        use("kevinhwang91/nvim-hlslens")
        use("windwp/nvim-autopairs")
    end

    -- quick-scope
    -- f/t is forward search, F/T is backward search, t version is cursorred before the selected character.
    vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
    -- CamelCaseMotion
    -- Activate normal operation with camel case determination (<leader> + w, b, e, ge)
    vim.g.camelcasemotion_key = "<leader>"

    m.setup_hop()
    m.setup_comment()

    if not vim.g.vscode then
        m.setup_neoclip()
        m.setup_autopairs()
        m.setup_hlslens()
    end
end

m.setup_hop = function()
    require("hop").setup()
end

m.setup_neoclip = function()
    require("neoclip").setup({
        enable_persistent_history = true,
    })
    require("telescope").load_extension("neoclip")
end

m.setup_comment = function()
    require("Comment").setup({
        pre_hook = function()
            return require("ts_context_commentstring.internal").calculate_commentstring()
        end,
        post_hook = nil,
    })
end

m.setup_hlslens = function()
    require("hlslens").setup()
end

m.setup_autopairs = function()
    require("nvim-autopairs").setup({
        map_cr = false,
    })
end

-- Jump to the beginning of the word shown.
vim.api.nvim_set_keymap("n", "<leader>m", [[<cmd>lua require('hop').hint_words()<CR>]], {})
vim.api.nvim_set_keymap("x", "<leader>m", [[<cmd>lua require('hop').hint_words()<CR>]], {})

if not vim.g.vscode then
    -- Search register by telescope.
    -- <CR> select
    -- p(normal) or <C-p>(insert) paste
    -- k(normal) or <C-k>(insert) paste-ehind
    -- q(normal) or <C-q>(insert) replay-macro
    -- d(normal) or <C-d>(insert) delete
    vim.api.nvim_set_keymap("n", "<leader>fr", "<Cmd>Telescope neoclip<CR>", { noremap = true, silent = true })

    -- Standard command extension (research in forward).
    vim.api.nvim_set_keymap(
        "n",
        "n",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        { noremap = true, silent = true }
    )
    -- Standard command extension (research backwards).
    vim.api.nvim_set_keymap(
        "n",
        "N",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        { noremap = true, silent = true }
    )
    -- Forward match search.
    vim.api.nvim_set_keymap("n", "*", [[g*<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true })
    -- Backward match search.
    vim.api.nvim_set_keymap("n", "g*", [[g#<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true })
end

return m
