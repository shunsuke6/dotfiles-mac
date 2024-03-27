local m = {}

m = {
	{
          "nvim-telescope/telescope.nvim", tag = '0.1.0',
          requires = {
              "nvim-lua/plenary.nvim",
        },
	{
          "nvim-telescope/telescope-fzf-native.nvim",
          run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	{"nvim-telescope/telescope-ui-select.nvim"},

     config = function()
         setup_telescope()
     end
    }
}

setup_telescope = function()
    -- Key mappings by default.
    -- <C-n>/<Down>	Next item
    -- <C-p>/<Up>	Previous item
    -- j/k	        Next/previous (in normal mode)
    -- H/M/L	    	Select High/Middle/Low (in normal mode)
    -- 'gg/G'	     	Select the first/last item (in normal mode)
    -- <CR>	        Confirm selection
    -- <C-x>	     	Go to file selection as a split
    -- <C-v>	    	Go to file selection as a vsplit
    -- <C-t>	    	Go to a file in a new tab
    -- <C-u>	    	Scroll up in preview window
    -- <C-d>	    	Scroll down in preview window
    -- <C-/>	    	Show mappings for picker actions (insert mode)
    -- ?	        Show mappings for picker actions (normal mode)
    -- <C-c>	    	Close telescope
    -- <Esc>	    	Close telescope (in normal mode)
    -- <Tab>	    	Toggle selection and move to next selection
    -- <S-Tab>	    	Toggle selection and move to prev selection
    -- <C-q>	    	Send all items not filtered to quickfixlist (qflist)
    -- <M-q>	    	Send all selected items to qflist
    local trouble = require("trouble.providers.telescope")
    require("telescope").setup({
        defaults = {
            mappings = {
                i = { ["<C-t>"] = trouble.open_with_trouble },
                n = { ["<C-t>"] = trouble.open_with_trouble },
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            }
        }
    })
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("notify")
    require("telescope").load_extension("ui-select")
end

vim.api.nvim_set_keymap("n", "<leader>fp", [[<cmd>lua require('telescope.builtin').builtin()<CR>]], { noremap = true })
vim.api.nvim_set_keymap(
    "n",
    "<leader>ff",
    [[<cmd>lua require('telescope.builtin').find_files()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap("n", "<leader>fF", [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true })
vim.api.nvim_set_keymap(
    "n",
    "<leader>fs",
    [[<cmd>lua require('telescope.builtin').grep_string()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>fg",
    [[<cmd>lua require('telescope.builtin').live_grep()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>fS",
    [[<cmd>lua require('telescope.builtin').search_history()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap("n", "<leader>fb", [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true })
vim.api.nvim_set_keymap(
    "n",
    "<leader>fB",
    [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap("n", "<leader>fc", [[<cmd>lua require('telescope.builtin').commands()<CR>]], { noremap = true })
vim.api.nvim_set_keymap(
    "n",
    "<leader>fC",
    [[<cmd>lua require('telescope.builtin').command_history()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>fR",
    [[<cmd>lua require('telescope.builtin').registers()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>fw",
    [[<cmd>lua require('telescope.builtin').spell_suggest()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap("n", "<leader>fq", [[<cmd>lua require('telescope.builtin').quickfix()<CR>]], { noremap = true })
vim.api.nvim_set_keymap(
    "n",
    "<leader>fQ",
    [[<cmd>lua require('telescope.builtin').quickfixhistory()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap("n", "<leader>fl", [[<cmd>lua require('telescope.builtin').loclist()<CR>]], { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fm", [[<cmd>lua require('telescope.builtin').marks()<CR>]], { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fj", [[<cmd>lua require('telescope.builtin').jumplist()<CR>]], { noremap = true })
vim.api.nvim_set_keymap(
    "n",
    "<leader>fh",
    [[<cmd>lua require('telescope.builtin').man_pages()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap("n", "<leader>fk", [[<cmd>lua require('telescope.builtin').keymaps()<CR>]], { noremap = true })
vim.api.nvim_set_keymap(
    "n",
    "<leader>fv",
    [[<cmd>lua require('telescope.builtin').vim_options()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>fa",
    [[<cmd>lua require('telescope.builtin').autocommands()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>ft",
    [[<cmd>lua require('telescope.builtin').filetypes()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>fT",
    [[<cmd>lua require('telescope.builtin').colorscheme()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>fH",
    [[<cmd>lua require('telescope.builtin').highlights()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>fn",
    [[<cmd>lua require('telescope.builtin').treesitter()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>gb",
    [[<cmd>lua require('telescope.builtin').git_branches()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>gc",
    [[<cmd>lua require('telescope.builtin').git_commits()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>gC",
    [[<cmd>lua require('telescope.builtin').git_bcommits()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>gf",
    [[<cmd>lua require('telescope.builtin').git_files()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>gg",
    [[<cmd>lua require('telescope.builtin').git_status()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>gs",
    [[<cmd>lua require('telescope.builtin').git_stash()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>ld",
    [[<cmd>lua require('telescope.builtin').lsp_definitions()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>lt",
    [[<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>li",
    [[<cmd>lua require('telescope.builtin').lsp_implementations()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>lr",
    [[<cmd>lua require('telescope.builtin').lsp_references()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>ls",
    [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>lw",
    [[<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>ll",
    [[<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>]],
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>lD",
    [[<cmd>lua require('telescope.builtin').diagnostics()<CR>]],
    { noremap = true }
)

return m
