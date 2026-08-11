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
					model = "claude-sonnet-5",
				},
			},
		},
		opts = {
			log_level = "DEBUG",
		},

		-- TODO: setup acp
	},
}

return m
