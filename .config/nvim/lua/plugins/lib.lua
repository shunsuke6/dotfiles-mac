local m = {}

m.setup = function(use)
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-tree/nvim-web-devicons")
    use("MunifTanjim/nui.nvim")
    use("tami5/sqlite.lua")
    use("tpope/vim-repeat")
end

return m
