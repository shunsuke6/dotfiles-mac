local m = {}

m = {
    "sidebar-nvim/sidebar.nvim",
    keys = {
        { "gs", "<Cmd>SidebarNvimToggle<CR>", mode = "n", { noremap = true, silent = true } },
        {
            "gS",
            ":lua require('sidebar-nvim.builtin.todos').toggle_all()<CR>",
            mode = "n",
            { noremap = true, silent = true },
        },
    },
    config = function()
        require("sidebar-nvim").setup({
            disable_default_keybindings = 0,
            bindings = {
                ["q"] = function()
                    require("sidebar-nvim").close()
                end,
            },
            open = false,
            side = "right",
            initial_width = 40,
            hide_statusline = false,
            update_interval = 1000,
            sections = {
                "datetime",
                "containers",
                "git",
                "diagnostics",
                "todos",
                "symbols",
                "buffers",
                "files",
            },
            section_separator = "------------------------------",
            datetime = {
                icon = "",
                format = "%b %d日 (%a) %H:%M",
                clocks = { { name = "local" } },
            },
            ["git"] = {
                icon = "",
            },
            ["diagnostics"] = {
                icon = "",
            },
            todos = {
                icon = "",
                ignored_paths = { "~" },
                initially_closed = false,
            },
            containers = {
                icon = "",
                use_podman = false,
                attach_shell = "/bin/bash",
                show_all = true,
                interval = 5000,
            },
            buffers = {
                icon = "",
                ignored_buffers = {},
                sorting = "id",
                show_numbers = true,
            },
            files = {
                icon = "",
                show_hidden = true,
                ignored_paths = { "%.git$" },
            },
            symbols = {
                icon = "ƒ",
            },
        })
    end,
}

return m
