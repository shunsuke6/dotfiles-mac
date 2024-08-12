local m = {}

local package_info = {
    "vuki656/package-info.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    config = function()
        require("package-info").setup({
            colors = {
                up_to_date = "#3C4048",
                outdated = "#d19a66",
            },
            icons = {
                enable = true,
                style = {
                    up_to_date = "|  ",
                    outdated = "|  ",
                },
            },
            autostart = true,
            hide_up_to_date = true,
            hide_unstable_versions = false,
            package_manager = "npm",
        })
    end,
    keys = {
        {
            "<leader><leader>nn",
            ":lua require('package-info').show()<CR>",
            mode = "n",
            { silent = true, noremap = true },
        },
        {
            "<leader><leader>nc",
            ":lua require('package-info').hide()<CR>",
            mode = "n",
            { silent = true, noremap = true },
        },
        {
            "<leader><leader>nu",
            ":lua require('package-info').update()<CR>",
            mode = "n",
            { silent = true, noremap = true },
        },
        {
            "<leader><leader>nd",
            ":lua require('package-info').delete()",
            mode = "n",
            { silent = true, noremap = true },
        },
        {
            "<leader><leader>ni",
            ":lua require('package-info').install()<CR>",
            mode = "n",
            { silent = true, noremap = true },
        },
        {
            "<leader><leader>nr",
            ":lua require('package-info').reinstall()<CR>",
            mode = "n",
            { silent = true, noremap = true },
        },
        {

            mode = "n",
            "<leader><leader>np",
            ":lua require('package-info').change_version()",
            { silent = true, noremap = true },
        },
    },
}

local regexplainer = {
    "bennypowers/nvim-regexplainer",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("regexplainer").setup({
            mode = "narrative",
            auto = false,
            filetypes = {
                "html",
                "js",
                "cjs",
                "mjs",
                "ts",
                "jsx",
                "tsx",
                "cjsx",
                "mjsx",
            },
            debug = false,
            display = "popup",
            mappings = {
                toggle = "<space>R",
            },
            narrative = {
                separator = "\n",
            },
        })
    end,
}
m = {
    package_info,
    regexplainer,
}

return m
