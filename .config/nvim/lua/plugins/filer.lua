local m = {}
    vim.g.neo_tree_remove_legacy_commands = 1
m = {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },

}

m.opts =  {

        close_if_last_window = false,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        default_component_configs = {
            container = {
                enable_character_fade = true,
            },
            indent = {
                indent_size = 2,
                padding = 1,
                with_markers = true,
                indent_marker = "│",
                last_indent_marker = "└",
                highlight = "NeoTreeIndentMarker",
                with_expanders = nil,
                expander_collapsed = "",
                expander_expanded = "",
                expander_highlight = "NeoTreeExpander",
            },
            icon = {
                folder_closed = "", folder_open = "", folder_empty = "ﰊ", default = "*",
                highlight = "NeoTreeFileIcon",
            },
            modified = {
                symbol = "[+]",
                highlight = "NeoTreeModified",
            },
            name = {
                trailing_slash = false,
                use_git_status_colors = true,
                highlight = "NeoTreeFileName",
            },
            git_status = {
                symbols = {
                    added = "",
                    modified = "",
                    deleted = "✖",
                    renamed = "",
                    untracked = "",
                    ignored = "",
                    unstaged = "",
                    staged = "",
                    conflict = "",
                },
            },
        },
        window = {
            position = "left",
            width = 40,
            mapping_options = {
                noremap = true,
                nowait = true,
            },
            mappings = {
                ["<space>"] = {
                    "toggle_node",
                    nowait = false,
                },
                ["<2-LeftMouse>"] = "open",
                ["<cr>"] = "open",
                ["S"] = "open_split",
                ["s"] = "open_vsplit",
                ["t"] = "open_tabnew",
                ["C"] = "close_node",
                ["a"] = {
                    "add",
                    config = {
                        show_path = "none",
                    },
                },
                ["A"] = "add_directory",
                ["d"] = "delete",
                ["r"] = "rename",
                ["y"] = "copy_to_clipboard",
                ["x"] = "cut_to_clipboard",
                ["p"] = "paste_from_clipboard",
                ["c"] = "copy",
                ["m"] = "move",
                ["q"] = "close_window",
                ["R"] = "refresh",
		        ["O"] = "expand_all_nodes",
                ["?"] = "show_help",
            },
        },
        nesting_rules = {},
        filesystem = {
            filtered_items = {
                visible = false,
                hide_dotfiles = false,
                hide_gitignored = false,
                hide_hidden = true,
                hide_by_name = {
                    --"node_modules"
                },
                -- uses glob style patterns
                hide_by_pattern = {
                    --"*.meta"
                },
                -- remains hidden even if visible is toggled to true
                never_show = {
                    ".DS_Store",
                    --"thumbs.db"
                },
            },
            follow_current_file = {
		    enabled = false,
	    },
            group_empty_dirs = false,
            hijack_netrw_behavior = "open_default",
            use_libuv_file_watcher = false,
            window = {
                mappings = {
                    ["<bs>"] = "navigate_up",
                    ["."] = "set_root",
                    ["H"] = "toggle_hidden",
                    ["/"] = "fuzzy_finder",
                    ["f"] = "filter_on_submit",
                    ["<c-x>"] = "clear_filter",
                    ["[g"] = "prev_git_modified",
                    ["]g"] = "next_git_modified",
                },
            },
        },
        buffers = {
            follow_current_file = {
		    enabled = true,
	    },
            group_empty_dirs = true,
            show_unloaded = true,
            window = {
                mappings = {
                    ["bd"] = "buffer_delete",
                    ["<bs>"] = "navigate_up",
                    ["."] = "set_root",
                },
            },
        },
        git_status = {
            window = {
                position = "float",
                mappings = {
                    ["A"] = "git_add_all",
                    ["gu"] = "git_unstage_file",
                    ["ga"] = "git_add_file",
                    ["gr"] = "git_revert_file",
                    ["gc"] = "git_commit",
                    ["gp"] = "git_push",
                    ["gg"] = "git_commit_and_push",
                },
            },
        },
    }




vim.keymap.set("n", "gx", "<Cmd>Neotree filesystem reveal toggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "gz", "<Cmd>Neotree buffers toggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "gX", "<Cmd>Neotree git_status show<CR>", { noremap = true, silent = true })

return m
