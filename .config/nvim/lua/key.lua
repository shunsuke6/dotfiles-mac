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

-- Japanese

api.nvim_set_keymap("n", "っd", "dd", { noremap = true, silent = true })
api.nvim_set_keymap("n", "っy", "yy", { noremap = true, silent = true })

-- Insert mode C ''
api.nvim_set_keymap("i", "<C-j>", "<down>", { noremap = true, silent = true })
api.nvim_set_keymap("i", "<C-k>", "<up>", { noremap = true, silent = true })
api.nvim_set_keymap("i", "<C-h>", "<left>", { noremap = true, silent = true })
api.nvim_set_keymap("i", "<C-l>", "<right>", { noremap = true, silent = true })
api.nvim_set_keymap("i", "<C-x>", "<delete>", { noremap = true, silent = true })

-- Don't yank
api.nvim_set_keymap("n", "x", '"_x', { noremap = true })
