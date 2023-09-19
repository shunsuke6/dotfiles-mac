local m = {}

m = {
        "EdenEast/nightfox.nvim",
        config = function()
            setup_nightfox()
        end,
    }

setup_nightfox = function()
    require("nightfox").setup({
        options = {
            transparent = true,
        },
    })
    vim.cmd("colorscheme nightfox")
end

return m
