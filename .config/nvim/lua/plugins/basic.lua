local m = {}

local hop = {
    "phaazon/hop.nvim",
    keys = {
        { "f", "<cmd>lua require('hop').hint_words()<CR>", mode = "n" },
        { "f", "<cmd>lua require('hop').hint_words()<CR>", mode = "x" },
    },
    config = function()
        require("hop").setup()
    end,
}

local quick_scope = {
    "unblevable/quick-scope",
    init = function()
        -- f/t is forward search, F/T is backward search, t version is cursorred before the selected character.
        vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
    end,
}

local camel_case_motion = {
    "bkad/CamelCaseMotion",
    init = function()
        -- Activate normal operation with camel case determination (<leader> + w, b, e, ge)
        vim.g.camelcasemotion_key = "<leader>"
    end,
}

local vim_sandwich = {
    "machakann/vim-sandwich",
}

local comment = {
    "numToStr/Comment.nvim",
    opts = {
            -- pre_hook = function()
            --     return require("ts_context_commentstring.ingegrations.comment_nvim").create_pre_hoook()
            -- end,
            -- post_hook = nil,
    },
    lazy = false,
}

local neoclip = {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
        { "tami5/sqlite.lua", module = "sqlite" },
        { "nvim-telescope/telescope.nvim" },
    },
    keys = {
        { "<leader>fr", "<Cmd>Telescope neoclip<CR>", mode = "n", { noremap = true, silent = true } },
    },
    config = function()
        require("neoclip").setup({
            enable_persistent_history = true,
        })
        require("telescope").load_extension("neoclip")
    end,
}

local hlslens = {
    "kevinhwang91/nvim-hlslens",
    keys = {
        {
            "n",
            "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>",
            mode = "n",
            { noremap = true, silent = true },
        },
        {
            "N",
            "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>",
            mode = "n",
            { noremap = true, silent = true },
        },
        { "*", "g*<Cmd>lua require('hlslens').start()<CR>", mode = "n", { noremap = true, silent = true } },
        { "g*", "g#<Cmd>lua require('hlslens').start()<CR>", mode = "n", { noremap = true, silent = true } },
    },
    config = function()
        require("hlslens").setup()
    end,
}

local autopairs = {
    "windwp/nvim-autopairs",
    config = function()
        require("nvim-autopairs").setup({
            map_cr = false,
        })
    end,
}

m = {
    hop,
    quick_scope,
    camel_case_motion,
    vim_sandwich,
    comment,
}
if not vim.g.vscode then
    local m2 = {
        neoclip,
        hlslens,
        autopairs,
    }
    for _, v in ipairs(m2) do
        table.insert(m, v)
    end
end

return m
