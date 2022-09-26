local m = {}

m.setup = function(use)
    use("rcarriga/nvim-notify")

    m.setup_notify()
end

m.setup_notify = function()
    require("notify").setup({
        stages = "fade_in_slide_out",
        background_colour = "FloatShadow",
        timeout = 3000,
    })
    vim.notify = require("notify")
end

vim.api.nvim_set_keymap("n", "<leader>fN", "<Cmd>Telescope notify<CR>", { noremap = true })

return m
