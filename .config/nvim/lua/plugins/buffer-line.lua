local m = {}
m = {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
        { "<leader>n", "<Cmd>BufferLineCycleNext<CR>", mode = "n", { noremap = true, silent = true } },
        { "<leader>p", "<Cmd>BufferLineCyclePrev<CR>", mode = "n", { noremap = true, silent = true } },
        { "<leader>N", "<Cmd>BufferLineMoveNext<CR>", mode = "n", { noremap = true, silent = true } },
        { "<leader>P", "<Cmd>BufferLineMovePrev<CR>", mode = "n", { noremap = true, silent = true } },
        { "<leader>E", "<Cmd>BufferLineSortByExtension<CR>", mode = "n", { noremap = true, silent = true } },
        { "<leader>D", "<Cmd>BufferLineSortByDirectory<CR>", mode = "n", { noremap = true, silent = true } },
        { "<Leader>B", "<Cmd>BufferLinePick<CR>", mode = "n", { noremap = true, silent = true } },
        { "<Leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", mode = "n", { noremap = true, silent = true } },
        { "<Leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", mode = "n", { noremap = true, silent = true } },
        { "<Leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", mode = "n", { noremap = true, silent = true } },
        { "<Leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", mode = "n", { noremap = true, silent = true } },
        { "<Leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", mode = "n", { noremap = true, silent = true } },
        { "<Leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", mode = "n", { noremap = true, silent = true } },
        { "<Leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", mode = "n", { noremap = true, silent = true } },
        { "<Leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", mode = "n", { noremap = true, silent = true } },
        { "<Leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", mode = "n", { noremap = true, silent = true } },
        { "<Leader>q", "<Cmd>BufferLinePickClose<CR>", mode = "n", { noremap = true, silent = true } },
        { "<Leader>L", "<Cmd>BufferLineCloseLeft<CR>", mode = "n", { noremap = true, silent = true } },
        { "<Leader>R", "<Cmd>BufferLineCloseRight<CR>", mode = "n", { noremap = true, silent = true } },
    },

    config = function()
        require("bufferline").setup({
            options = {
                numbers = "both",
                diagnostics = "nvim_lsp",
                show_buffer_close_icons = false,
                show_close_icon = false,
                custom_filter = function(buf_number)
                    if vim.bo[buf_number].filetype == "qf" then
                        return false
                    end
                    if vim.bo[buf_number].buftype == "terminal" then
                        return false
                    end
                    if vim.fn.bufname(buf_number) == "" or vim.fn.bufname(buf_number) == "[No Name]" then
                        return false
                    end
                    if vim.fn.bufname(buf_number) == "[dap-repl]" then
                        return false
                    end

                    return true
                end,
            },
        })
    end,
}

return m
