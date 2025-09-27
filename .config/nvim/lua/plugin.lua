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
    require("plugins.java"),
    require("plugins.lsp"),
    require("plugins.completion"),
    require("plugins.fzf"),
    require("plugins.treesitter"),
    require("plugins.status-line"),
    require("plugins.buffer-line"),
    require("plugins.sidebar"),
    require("plugins.filer"),
    require("plugins.scrollbar"),
    require("plugins.start-page"),
    require("plugins.terminal"),
    require("plugins.help"),
    require("plugins.highlight"),
    require("plugins.basic"),
    require("plugins.command"),
    require("plugins.repl"),
    require("plugins.dap"),
    require("plugins.git"),
    require("plugins.github"),
    require("plugins.markdown"),
    require("plugins.javascript"),
    require("plugins.dart"),
    require("plugins.sql"),
    require("plugins.log"),
    require("plugins.null-ls"),
    --    require("plugins.toys"),
    require("plugins.copilot"),
    require("plugins.codecompanion"),
})
