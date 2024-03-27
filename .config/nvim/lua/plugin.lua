-- Load plugins.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    require("plugins.command"),
    require("plugins.lib"),
        require("plugins.notify"),
        require("plugins.colorscheme"),
--        require("plugins.lsp"),
        require("plugins.completion"),
        require("plugins.fzf"),
--        require("plugins.treesitter"),
--        require("plugins.status-line"),
        require("plugins.buffer-line"),
--        require("plugins.sidebar"),
        require("plugins.filer"),
--        require("plugins.scrollbar"),
--        require("plugins.start-page"),
--        require("plugins.terminal"),
--        require("plugins.help"),
--        require("plugins.highlight"),
    require("plugins.basic"),
--  require("plugins.command"),
--        require("plugins.repl"),
--        require("plugins.dap"),
--        require("plugins.git"),
--        require("plugins.github"),
--        require("plugins.markdown"),
--        require("plugins.javascript"),
--        require("plugins.java"),
--        require("plugins.dart"),
--        require("plugins.sql"),
--        require("plugins.log"),
       require("plugins.null-ls"),
--    require("plugins.toys"),
--    require("plugins.copilot"),
})

-- vim.cmd([[packadd packer.nvim]])
-- require("packer").startup(function(use)
--    use({
--        "wbthomason/packer.nvim",
--        opt = true,
--    })
--
--    require("plugins.lib").setup(use)
--
--    if not vim.g.vscode then
--        require("plugins.notify").setup(use)
--        require("plugins.colorscheme").setup(use)
--        require("plugins.lsp").setup(use)
--        require("plugins.completion").setup(use)
--        require("plugins.fzf").setup(use)
--        require("plugins.treesitter").setup(use)
--        require("plugins.status-line").setup(use)
--        require("plugins.buffer-line").setup(use)
--        require("plugins.sidebar").setup(use)
--        require("plugins.filer").setup(use)
--        require("plugins.scrollbar").setup(use)
--        require("plugins.start-page").setup(use)
--        require("plugins.terminal").setup(use)
--        require("plugins.help").setup(use)
--        require("plugins.highlight").setup(use)
--    end
--    require("plugins.basic").setup(use)
    --require("plugins.command")
--    if not vim.g.vscode then
--        require("plugins.repl").setup(use)
--        require("plugins.dap").setup(use)
--        require("plugins.git").setup(use)
--        require("plugins.github").setup(use)
--        require("plugins.markdown").setup(use)
--        require("plugins.javascript").setup(use)
--        require("plugins.java").setup(use)
--        require("plugins.dart").setup(use)
--        require("plugins.sql").setup(use)
--        require("plugins.log").setup(use)
--        require("plugins.null-ls").setup(use)
--    end
--    require("plugins.toys").setup(use)
--    require("plugins.copilot").setup(use)
---- end)
