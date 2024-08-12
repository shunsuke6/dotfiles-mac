local m = {}

m = {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreveiwStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    -- An awesome automatic table creator & formatter allowing one to create neat tables as you type.
    -- Default key mappings.
    -- :TableModeToggle     <Leader>tm
    -- :TableModeRealign    <Leader>tr
    -- :Tableize            <Leader>tt
    -- :Tableize/{pattern}  <Leader>T
    -- [| , ]| , {| , }|    to move left | right | up | down cells
    -- i| , a|              for the inner and around the table cell
    -- <Leader>tdd          mapping to delete the current table row
    -- <Leader>tdc          mapping to delete the entire current column
    -- <Leader>tic          mapping to insert a column after the cursor
    -- See github for table formulas.
    { "dhruvasagar/vim-table-mode" },
}

vim.g.mkdp_theme =
    "dark", vim.api.nvim_set_keymap("n", "gm", "<Cmd>MarkdownPreviewToggle<CR>", { noremap = true, silent = true })

return m
