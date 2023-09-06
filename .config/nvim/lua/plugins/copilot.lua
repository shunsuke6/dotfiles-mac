local m = {}

m.setup = function(use)
    use("github/copilot.vim")
end

vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-t>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
return m
