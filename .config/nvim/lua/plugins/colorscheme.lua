local m = {}

m = {
    "EdenEast/nightfox.nvim",
    config = function()
        require("nightfox").setup({
            options = {
                transparent = true,
            },
        })
        vim.cmd("colorscheme nightfox")
    end,
}

return m
