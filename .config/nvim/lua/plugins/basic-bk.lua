local m = {}

hop = {
	"phaazon/hop.nvim",
	keys = {
		{ "<leader>", "<cmd>lua require('hop').hint_words()<CR>", mode = "n" },
		{ "<leader>", "<cmd>lua require('hop').hint_words()<CR>", mode = "x" },
	},
	config = function()
		require("hop").setup()
	end,
}

quick_scope = {
	"unblevable/quick-scope",
	config = function()
		-- f/t is forward search, F/T is backward search, t version is cursorred before the selected character.
		qs_highlight_on_keys = { "f", "F", "t", "T" }
	end,
}

camel_case_motion = {
	"bkad/CamelCaseMotion",
	config = function()
		-- Activate normal operation with camel case determination (<leader> + w, b, e, ge)
		camelcasemotion_key = "<leader>"
	end,
}

vim_sandwich = {
	"machakann/vim-sandwich",
}
comment = {
	"numToStr/Comment.nvim",
	opts = {
		pre_hook = function()
			return require("ts_context_commentstring.ingegrations.comment_nvim").create_pre_hoook()
		end,
		post_hook = nil,
	},
}

neoclip = {
	"AckslD/nvim-neoclip.lua",
	dependencies = {
		{ "tami5/sqlite.lua",             module = "sqlite" },
		{ "nvim-telescope/telescope.nvim" },
	},
	keys = {
		{ "<leader>fr", "<Cmd>Telescope neoclip<CR>", mode = "n", { noremap = true, silent = true } },
	},
	config = function()
		require("neoclip").setup({
			enable_persistent_history = true,
		})
		require("telescope").load_extension("neoclip")
	end,

	-- Search register by telescope.
	-- <CR> select
	-- p(normal) or <C-p>(insert) paste
	-- k(normal) or <C-k>(insert) paste-ehind
	-- q(normal) or <C-q>(insert) replay-macro
	-- d(normal) or <C-d>(insert) delete
}

local m = {
	hop,
	quick_scope,
	camel_case_motion,
	vim_sandwich,
	--comment,
}

hlslens = {
	"kevinhwang91/nvim-hlslens",
	keys = {
		{
			"n",
			"<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>",
			mode = "n",
			{ noremap = true, silent = true },
		},
		{
			"N",
			"<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>",
			mode = "n",
			{ noremap = true, silent = true },
		},
		{ "*",  "g*<Cmd>lua require('hlslens').start()<CR>", mode = "n", { noremap = true, silent = true } },
		{ "g*", "g#<Cmd>lua require('hlslens').start()<CR>", mode = "n", { noremap = true, silent = true } },
	},
	config = function()
		require("hlslens").setup()
	end,
}

autopairs = {
	"windwp/nvim-autopairs",
	config = function()
		require("nvim-autopairs").setup({
			map_cr = false,
		})
	end,
}

if not vim.g.vscode then
	local m2 = {
		neoclip,
		hlslens,
		autopairs,
	}

	for _, v in ipairs(m2) do
		table.insert(m, v)
	end
end

setup_comment = function()
	require("Comment").setup({
		pre_hook = function()
			return require("ts_context_commentstring.internal").calculate_commentstring()
		end,
		post_hook = nil,
	})
end

return m
