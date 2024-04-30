local m = {}

m = {
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
    },
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    { "RRethy/nvim-treesitter-textsubjects" },
    { "mfussenegger/nvim-ts-hint-textobject" },
    { "David-Kunz/treesitter-unit" },
    { "mizlan/iswap.nvim" },
    { "JoosepAlviste/nvim-ts-context-commentstring" },
    { "andymass/vim-matchup" },

    { "nvim-treesitter/nvim-treesitter-context" },
    { "haringsrob/nvim_context_vt" },
    {
        "m-demare/hlargs.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
    },
    { "windwp/nvim-ts-autotag" },
    {
        "HiPhish/rainbow-delimiters.nvim",
        config = function()
            local rainbow_delimiters = require("rainbow-delimiters")
            require("rainbow-delimiters.setup")({
                strategy = {
                    [""] = function()
                        return nil
                    end,
                    commonlisp = rainbow_delimiters.strategy["global"],
                    scheme = rainbow_delimiters.strategy["global"],
                    query = rainbow_delimiters.strategy["global"],
                    clojure = rainbow_delimiters.strategy["global"],
                    html = rainbow_delimiters.strategy["global"],
                },
            })
        end,
    },

    config = function()
        setup_treesitter()
        setup_context()
        setup_context_vt()
        setup_hlargs()
        setup_autotag()
    end,
}

setup_treesitter = function()
    require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        sync_install = true,
        highlight = {
            enable = true,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<CR>",
                node_incremental = "<CR>",
                scope_incremental = "<TAB>",
                node_decremental = "<S-TAB>",
            },
        },
        indent = {
            enable = not vim.g.vscode,
        },
        textobjects = {
            select = {
                enable = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                    ["aB"] = "@block.outer",
                    ["iB"] = "@block.inner",
                    ["ai"] = "@conditional.outer",
                    ["ii"] = "@conditional.inner",
                    ["al"] = "@loop.outer",
                    ["il"] = "@loop.inner",
                    ["ap"] = "@parameter.outer",
                    ["ip"] = "@parameter.inner",
                    -- ["aF"] = "@frame.outer",
                    -- ["iF"] = "@frame.inner",
                    -- ["aS"] = "@statement.outer",
                    -- ["iS"] = "@scopename.inner",
                    -- ["a"] = "@comment.outer",
                    -- ["a"] = "@call.outer",
                    -- ["i"] = "@call.inner",
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<leader>sn"] = "@parameter.inner",
                },
                swap_previous = {
                    ["<leader>sp"] = "@parameter.inner",
                },
            },
            move = {
                enable = true,
                goto_next_start = {
                    ["]m"] = "@function.outer",
                    ["]]"] = "@class.outer",
                },
                goto_next_end = {
                    ["]M"] = "@function.outer",
                    ["]["] = "@class.outer",
                },
                goto_previous_start = {
                    ["[m"] = "@function.outer",
                    ["[["] = "@class.outer",
                },
                goto_previous_end = {
                    ["[M"] = "@function.outer",
                    ["[]"] = "@class.outer",
                },
            },
            lsp_interop = {
                enable = false,
                peek_definition_code = {
                    ["<leader>lf"] = "@function.outer",
                    ["<leader>lc"] = "@class.outer",
                },
            },
        },
        textsubjects = {
            enable = true,
            prev_selection = ",",
            keymaps = {
                ["."] = "textsubjects-smart",
                [";"] = "textsubjects-container-outer",
                ["i;"] = "textsubjects-container-inner",
            },
        },
        context_commentstring = {
            enable = true,
        },
        matchup = {
            enable = false,
        },
        autotag = {
            enable = not vim.g.vscode,
        },
    })
end

setup_context = function()
    require("treesitter-context").setup({
        enable = true,
    })
end

setup_context_vt = function()
    require("nvim_context_vt").setup({
        enabled = true,
        disable_virtual_lines = true,
    })
end

setup_autotag = function()
    require("nvim-ts-autotag").setup()
end

setup_hlargs = function()
    require("hlargs").setup()
end

vim.api.nvim_set_keymap("x", "iu", [[:lua require('treesitter-unit').select()<CR>]], { noremap = true })
vim.api.nvim_set_keymap("x", "au", [[:lua require('treesitter-unit').select(true)<CR>]], { noremap = true })
vim.api.nvim_set_keymap("o", "iu", [[:<c-u>lua require('treesitter-unit').select()<CR>]], { noremap = true })
vim.api.nvim_set_keymap("o", "au", [[:<c-u>lua require('treesitter-unit').select(true)<CR>]], { noremap = true })
vim.cmd([[omap <silent> m :<C-u>lua require('tsht').nodes()<CR>]]) -- motion
vim.cmd([[vnoremap <silent> m :lua require('tsht').nodes()<CR>]]) -- motion
vim.api.nvim_set_keymap("n", "<Leader>ss", "<cmd>ISwap<CR>", { noremap = true }) -- swap motion
vim.api.nvim_set_keymap("n", "<Leader>sw", "<cmd>ISwapWith<CR>", { noremap = true }) -- swap motion with

return m
