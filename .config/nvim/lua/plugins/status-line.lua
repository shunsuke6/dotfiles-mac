local m = {}

local lualine = {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
    config = function()
        require("lualine").setup({
            options = {
                theme = "nightfox",
                refresh = {
                    statusline = 200,
                    tabline = 500,
                    winbar = 300,
                },
            },
            always_divide_middle = true,
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
                    "navic",
                    -- { navic.get_location, cond = navic.is_available },
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
        "neovim/nvim-lspconfig",
    },
    config = function()
        require("nvim-navic").setup({
            lsp = {
                auto_attach = true,
            },
            highlight = true,
        })
    end,
}

m = {
    lualine,
    navic,
}

return m
