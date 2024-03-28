local m = {}

m = {
	"github/copilot.vim",
	config = function()
		setup_copilot()
	end,
      }

setup_copilot = function(use)
    use()
    vim.g.copilot_no_tab_map = true
    vim.api.nvim_set_keymap("i", "<C-t>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
end

return m

