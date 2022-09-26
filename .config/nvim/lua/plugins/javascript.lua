local m = {}

m.setup = function(use)
    use({
        "vuki656/package-info.nvim",
        requires = "MunifTanjim/nui.nvim",
    })
    use({
        "bennypowers/nvim-regexplainer",
        requires = {
            "nvim-treesitter/nvim-treesitter",
            "MunifTanjim/nui.nvim",
        },
    })

    m.setup_package_info()
    m.setup_regexplainer()
end

m.setup_package_info = function()
    require("package-info").setup({
        colors = {
            up_to_date = "#3C4048",
            outdated = "#d19a66",
        },
        icons = {
            enable = true,
            style = {
                up_to_date = "|  ",
                outdated = "|  ",
            },
        },
        autostart = true,
        hide_up_to_date = true,
        hide_unstable_versions = false,
        package_manager = "npm",
    })
end

m.setup_regexplainer = function()
    require("regexplainer").setup({
        mode = "narrative",
        auto = false,
        filetypes = {
            "html",
            "js",
            "cjs",
            "mjs",
            "ts",
            "jsx",
            "tsx",
            "cjsx",
            "mjsx",
        },
        debug = false,
        display = "popup",
        mappings = {
            toggle = "<space>R",
        },
        narrative = {
            separator = "\n",
        },
    })
end

vim.api.nvim_set_keymap(
    "n",
    "<leader><leader>nn",
    ":lua require('package-info').show()<CR>",
    { silent = true, noremap = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader><leader>nc",
    ":lua require('package-info').hide()<CR>",
    { silent = true, noremap = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader><leader>nu",
    ":lua require('package-info').update()<CR>",
    { silent = true, noremap = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader><leader>nd",
    ":lua require('package-info').delete()",
    { silent = true, noremap = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader><leader>ni",
    ":lua require('package-info').install()<CR>",
    { silent = true, noremap = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader><leader>nr",
    ":lua require('package-info').reinstall()<CR>",
    { silent = true, noremap = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader><leader>np",
    ":lua require('package-info').change_version()",
    { silent = true, noremap = true }
)

return m
