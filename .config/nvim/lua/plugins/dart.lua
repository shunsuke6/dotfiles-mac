local m = {}

m = {
    "akinsho/flutter-tools.nvim",
    dependencies = "nvim-lua/plenary.nvim",

    config = function()
        local lsp = require("lib.lsp")
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
    end,
}
return m
