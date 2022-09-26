local m = {}

m.setup = function(use)
    use({
        "akinsho/flutter-tools.nvim",
        requires = "nvim-lua/plenary.nvim",
    })

    m.setup_flutter_tools()
end

m.setup_flutter_tools = function()
    local lsp = require("plugins.lsp")
    require("flutter-tools").setup({
        decorations = {
            statusline = {
                app_version = true,
                device = true,
            },
        },
        debugger = {
            enabled = true,
            run_via_dap = true,
        },
        flutter_lookup_cmd = "asdf where flutter",
        widget_guides = {
            enabled = true,
        },
        dev_log = {
            enabled = false,
        },
        lsp = {
            color = {
                enabled = true,
                background = true,
            },
            on_attach = lsp.on_attach,
            capabilities = lsp.get_capabilities(),
        },
    })
end
m.setup_telescope = function()
    require("telescope").load_extension("flutter")
end
return m
