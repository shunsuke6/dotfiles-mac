local m = {}

setup = {

    {
        "nvim-lualine/lualine.nvim",
        requires = {
            "kyazdani42/nvim-web-devicons",
            opt = true,
        },
    },
    {
        "SmiteshP/nvim-navic",
        requires = {
            "nvim-treesitter/nvim-treesitter",
        },
    },

    config = function()
        setup_gps()
        setup_lualine()
    end
}

setup_lualine = function()
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
end

setup_gps = function()
    require("nvim-navic").setup()
end

return m
