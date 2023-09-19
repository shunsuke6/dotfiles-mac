local m = {}


setup_notify = function()
    return function()
     require("notify").setup({
     stages = "fade_in_slide_out",
     background_colour = "FloatShadow",
     timeout = 3000,
     }) 
 end
end

m = 
{
    "rcarriga/nvim-notify",
    config = setup_notify(), 
    --vim.notify = require("notify"), 
}



vim.api.nvim_set_keymap("n", "<leader>fN", "<Cmd>Telescope notify<CR>", { noremap = true })

return m
