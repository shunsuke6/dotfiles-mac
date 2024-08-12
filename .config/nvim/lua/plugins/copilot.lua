local m = {}

m = {
    "github/copilot.vim",
    cmd = { "Copilot" },
    keys = {
        { mode = "i", "<C-t>", 'copilot#Accept("<CR>")', { silent = true, expr = true } },
    },
    init = function()
        vim.g.copilot_no_tab_map = true
    end,
}

return m
