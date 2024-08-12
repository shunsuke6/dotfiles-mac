local m = {}

local neogit = {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { mode = "n", "<leader><leader>gc", "<Cmd>Neogit kind=tab<CR>", { noremap = true, silent = true } },
        { mode = "n", "<leader><leader>gC", "<Cmd>Neogit commit<CR>", { noremap = true, silent = true } },
    },
    config = function()
        require("neogit").setup({
            disable_commit_confirmation = true,
            kind = "tab",
            commit_popup = {
                kind = "split",
            },
            integrations = {
                diffview = true,
            },
        })
    end,
}
local diffview = {
    "sindrets/diffview.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { mode = "n", "<leader><leader>gd", "<Cmd>DiffviewOpen<CR>", { noremap = true, silent = true } },
        { mode = "n", "<leader><leader>gh", "<Cmd>DiffviewFileHistory<CR>", { noremap = true, silent = true } },
    },
    config = function()
        local actions = require("diffview.actions")
        require("diffview").setup({
            diff_binaries = false,
            enhanced_diff_hl = false,
            use_icons = true,
            icons = {
                folder_closed = "",
                folder_open = "",
            },
            signs = {
                fold_closed = "",
                fold_open = "",
            },
            file_panel = {
                listing_style = "tree",
                tree_options = {
                    flatten_dirs = true,
                    folder_statuses = "only_folded",
                },
                win_config = {
                    position = "left",
                    width = 35,
                },
            },
            file_history_panel = {
                log_options = {
                    git = {
                        single_file = {
                            max_count = 512,
                            follow = true,
                        },
                        multi_file = {
                            max_count = 128,
                        },
                    },
                },
            },
            commit_log_panel = {
                win_config = {},
            },
            default_args = {
                DiffviewOpen = {},
                DiffviewFileHistory = {},
            },
            hooks = {},
            keymaps = {
                disable_defaults = false,
                view = {
                    ["<tab>"] = actions.select_next_entry,
                    ["<s-tab>"] = actions.select_prev_entry,
                    ["gf"] = actions.goto_file,
                    ["<C-w><C-f>"] = actions.goto_file_split,
                    ["<C-w>gf"] = actions.goto_file_tab,
                    ["<leader>e"] = actions.focus_files,
                    ["<leader>b"] = actions.toggle_files,
                },
                file_panel = {
                    ["j"] = actions.next_entry,
                    ["<down>"] = actions.next_entry,
                    ["k"] = actions.prev_entry,
                    ["<up>"] = actions.prev_entry,
                    ["<cr>"] = actions.select_entry,
                    ["o"] = actions.select_entry,
                    ["<2-LeftMouse>"] = actions.select_entry,
                    ["-"] = actions.toggle_stage_entry,
                    ["S"] = actions.stage_all,
                    ["U"] = actions.unstage_all,
                    ["X"] = actions.restore_entry,
                    ["R"] = actions.refresh_files,
                    ["L"] = actions.open_commit_log,
                    ["<c-d>"] = actions.scroll_view(-0.25),
                    ["<c-f>"] = actions.scroll_view(0.25),
                    ["<tab>"] = actions.select_next_entry,
                    ["<s-tab>"] = actions.select_prev_entry,
                    ["gf"] = actions.goto_file,
                    ["<C-w><C-f>"] = actions.goto_file_split,
                    ["<C-w>gf"] = actions.goto_file_tab,
                    ["i"] = actions.listing_style,
                    ["f"] = actions.toggle_flatten_dirs,
                    ["<leader>e"] = actions.focus_files,
                    ["<leader>b"] = actions.toggle_files,
                },
                file_history_panel = {
                    ["g!"] = actions.options,
                    ["<C-A-d>"] = actions.open_in_diffview,
                    ["y"] = actions.copy_hash,
                    ["L"] = actions.open_commit_log,
                    ["zR"] = actions.open_all_folds,
                    ["zM"] = actions.close_all_folds,
                    ["j"] = actions.next_entry,
                    ["<down>"] = actions.next_entry,
                    ["k"] = actions.prev_entry,
                    ["<up>"] = actions.prev_entry,
                    ["<cr>"] = actions.select_entry,
                    ["o"] = actions.select_entry,
                    ["<2-LeftMouse>"] = actions.select_entry,
                    ["<c-b>"] = actions.scroll_view(-0.25),
                    ["<c-f>"] = actions.scroll_view(0.25),
                    ["<tab>"] = actions.select_next_entry,
                    ["<s-tab>"] = actions.select_prev_entry,
                    ["gf"] = actions.goto_file,
                    ["<C-w><C-f>"] = actions.goto_file_split,
                    ["<C-w>gf"] = actions.goto_file_tab,
                    ["<leader>e"] = actions.focus_files,
                    ["<leader>b"] = actions.toggle_files,
                },
                option_panel = {
                    ["<tab>"] = actions.select_entry,
                    ["q"] = actions.close,
                },
            },
        })
    end,
}
local gitsigns = {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                map("n", "]h", function()
                    if vim.wo.diff then
                        return "]h"
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, desc = "Gitsigns next_hunk" })

                map("n", "[h", function()
                    if vim.wo.diff then
                        return "[h"
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, desc = "GitSigns prev_hunk" })

                map({ "n", "v" }, "<leader><leader>gs", ":Gitsigns stage_hunk<CR>")
                map({ "n", "v" }, "<leader><leader>gr", ":Gitsigns reset_hunk<CR>")
                map("n", "<leader><leader>gS", gs.stage_buffer, { desc = "Gitsigns stage_buffer" })
                map("n", "<leader><leader>gu", gs.undo_stage_hunk, { desc = "GitSigns undo_stage_hunk" })
                map("n", "<leader><leader>gR", gs.reset_buffer, { desc = "GitSigns reset_buffer" })
                map("n", "<leader><leader>gg", gs.preview_hunk, { desc = "GitSigns preview_hunk" })
                map("n", "<leader><leader>gb", function()
                    gs.blame_line({ full = true })
                end, { desc = "Gitsigns blame_line" })
                map(
                    "n",
                    "<leader><leader>gB",
                    gs.toggle_current_line_blame,
                    { desc = "Gitsigns toggle_current_line_blame" }
                )
                map("n", "<leader><leader>gD", gs.toggle_deleted, { desc = "Gitsigns toggle_deleted" })

                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
            end,
        })
    end,
}
m = {
    neogit,
    diffview,
    gitsigns,
}

return m
