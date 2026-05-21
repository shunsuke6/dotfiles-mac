local m = {}
local markdown_preview = {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreveiwStop" },
	ft = { "markdown" },
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	keys = { { "gm", "<Cmd>MarkdownPreviewToggle<CR>", mode = "n", { noremap = true, silent = true } } },
}
-- local markview = {
-- 	"OXY2DEV/markview.nvim",
-- 	lazy = false,
-- 	opts = {
-- 		preview = {
-- 			map_gx = false, -- disable auto mapping (used by NeoTree)
-- 		},
-- 	},
-- }
local rende_md = {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {},
}

m = {
	-- An awesome automatic table creator & formatter allowing one to create neat tables as you type.
	-- Default key mappings.
	-- :TableModeToggle     <Leader>tm
	-- :TableModeRealign    <Leader>tr
	-- :Tableize            <Leader>tt
	-- :Tableize/{pattern}  <Leader>T
	-- [| , ]| , {| , }|    to move left | right | up | down cells
	-- i| , a|              for the inner and around the table cell
	-- <Leader>tdd          mapping to delete the current table row
	-- <Leader>tdc          mapping to delete the entire current column
	-- <Leader>tic          mapping to insert a column after the cursor
	-- See github for table formulas.
	markdown_preview,
	-- markview,
	rende_md,
	{ "dhruvasagar/vim-table-mode" },
}

return m
