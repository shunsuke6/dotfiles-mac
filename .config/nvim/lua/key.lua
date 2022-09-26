local api = vim.api

if not vim.g.vscode then
    -- Move window.
    api.nvim_set_keymap("n", "<C-h>", "<C-w><C-h>", { noremap = true, silent = true })
    api.nvim_set_keymap("n", "<C-j>", "<C-w><C-j>", { noremap = true, silent = true })
    api.nvim_set_keymap("n", "<C-k>", "<C-w><C-k>", { noremap = true, silent = true })
    api.nvim_set_keymap("n", "<C-l>", "<C-w><C-l>", { noremap = true, silent = true })
    -- Close tab.
    api.nvim_set_keymap("n", "<M-q>", "<Cmd>tabclose<CR>", { noremap = true, silent = true })
end

-- No highlight.
api.nvim_set_keymap("n", "<Leader>h", ":noh<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "あ", "a" , { noremap = true , silent = true })
api.nvim_set_keymap("n", "い", "i" , { noremap = true , silent = true })
api.nvim_set_keymap("n", "う", "u" , { noremap = true , silent = true })
api.nvim_set_keymap("n", "Ｕ", "U" , { noremap = true , silent = true })
api.nvim_set_keymap("n", "え", "e" , { noremap = true , silent = true })
api.nvim_set_keymap("n", "お", "o" , { noremap = true , silent = true })
api.nvim_set_keymap("n", "O", "O" , { noremap = true , silent = true })
api.nvim_set_keymap("n", "ｄｄ", "dd" , { noremap = true , silent = true })
api.nvim_set_keymap("n", "ｙｙ", "yy" , { noremap = true , silent = true })
api.nvim_set_keymap("n", "ｐ", "p" , { noremap = true , silent = true })
api.nvim_set_keymap("n", "Ｐ", "P" , { noremap = true , silent = true })
api.nvim_set_keymap("n", "ｎ", "n" , { noremap = true , silent = true })
api.nvim_set_keymap("n", "Ｎ", "N" , { noremap = true , silent = true })
-- insert mode C ''
api.nvim_set_keymap("i", "<C-j>", "<down>" , { noremap = true , silent = true })
api.nvim_set_keymap("i", "<C-k>", "<up>" , { noremap = true , silent = true })
api.nvim_set_keymap("i", "<C-h>", "<left>" , { noremap = true , silent = true })
api.nvim_set_keymap("i", "<C-l>", "<right>" , { noremap = true , silent = true })
api.nvim_set_keymap("i", "<C-x>", "<delete>" , { noremap = true , silent = true })


