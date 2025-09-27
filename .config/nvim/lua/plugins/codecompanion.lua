local m = {}

m = {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        strategies = {
            chat = {
                name = "copilot",
                model = "gpt-4.1",
            },
        },
        opts = {
            log_level = "DEBUG",
        },

        -- TODO: setup acp
        -- adapters = {
        --     acp = {
        --         gemini_cli = function()
        --             return require("codecompanion.adapters").extend("gemini_cli", {
        --                 env = {
        --                     api_key = "",
        --                 },
        --             })
        --         end,
        --     },
        -- },
    },
}

return m
