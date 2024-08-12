local m = {}

local lualine = {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        opt = true,
    },
    config = function()
        local navic = require("nvim-navic")
        require("lualine").setup({
            options = {
                theme = "nightfox",
            },
            sections = {
                lualine_a = {
                    "mode",
                },
                lualine_b = {
                    "branch",
                    "diff",
                    "diagnostics",
                },
                lualine_c = {
                    "filename",
                    { navic.get_location, cond = navic.is_available },
                },
                lualine_x = {
                    "encoding",
                    "fileformat",
                    "filetype",
                },
                lualine_y = {
                    "progress",
                },
                lualine_z = {
                    "location",
                },
            },
        })
    end,
}

local navic = {
    "SmiteshP/nvim-navic",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("nvim-navic").setup()
    end,
}

m = {
    lualine,
    navic,
}

return m
