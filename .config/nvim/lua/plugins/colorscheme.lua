local m = {}

m.setup = function(use)
    use("EdenEast/nightfox.nvim")

    m.setup_nightfox()
end

m.setup_nightfox = function()
    require("nightfox").setup({
        options = {
            transparent = true,
        },
    })
    vim.cmd("colorscheme nightfox")
end

return m
