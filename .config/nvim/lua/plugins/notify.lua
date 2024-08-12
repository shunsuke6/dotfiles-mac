local m = {}

m = {
    "rcarriga/nvim-notify",
    keys = {
        { "<leader>fN", "<Cmd>Telescope notify<CR>", mode = "n", { noremap = true } },
    },
    config = function()
        require("notify").setup({
            stages = "fade_in_slide_out",
            background_colour = "FloatShadow",
            timeout = 3000,
        })
    end,
}

return m
