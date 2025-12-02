local m = {}

m = {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		strategies = {
			chat = {
				adapter = {
					name = "copilot",
					model = "claude-sonnet-4.5",
				},
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
