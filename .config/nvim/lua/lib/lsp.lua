local m = {}

m.on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local opts = { noremap = true, silent = true }
    buf_set_keymap("n", "<space>gD", "lua vim.lsp.buf.declaration()", opts)

    buf_set_keymap("n", "gd", "lua vim.lsp.buf.definition()", opts)

    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)

    buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)

    buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)

    buf_set_keymap("n", "<space>l", "lua vim.lsp.diagnostic.set_loclist()", opts)
    buf_set_keymap("n", "<space>q", "lua vim.lsp.diagnostic.set_qflist()", opts)
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
end

m.get_capabilities = function()
    require("cmp_nvim_lsp").default_capabilities()
end

return m
