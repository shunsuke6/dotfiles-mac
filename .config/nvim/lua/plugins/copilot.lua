local m = {}

m = {
    "github/copilot.vim",
    lazy = false,
    cmd = { "Copilot" },
    -- keys = {
    --     { mode = "i", "<C-t>", 'copilot#Accept("\\<CR>")', { silent = true, expr = true } },
    -- },
    config = function()
      vim.cmd([[
        imap <silent><script><expr> <C-t> copilot#Accept("\<CR>")
        let g:copilot_no_tab_map = v:true
      ]])
    end
}

return m
