local m = {}

m.setup = function(use)
    use("neovim/nvim-lspconfig")
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("hrsh7th/cmp-nvim-lsp")
    use("tami5/lspsaga.nvim")
    use("folke/lsp-colors.nvim")
    use({
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
    })
    use("j-hui/fidget.nvim")
    use("RRethy/vim-illuminate")

    vim.g.Illuminate_delay = 500
    vim.g.Illuminate_highlightUnderCursor = 0

    m.setup_lsp()
    m.setup_lspsaga()
    m.setup_lsp_color()
    m.setup_trouble()
    m.setup_fidget()
end

m.on_attach = function(client, bufnr)
    require("illuminate").on_attach(client)

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local opts = { noremap = true, silent = true }

    buf_set_keymap("n", "gD", "lua vim.lsp.buf.declaration()", opts)

    buf_set_keymap("n", "gd", "lua vim.lsp.buf.definition()", opts)

    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)

    buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)

    buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)

    buf_set_keymap("n", "<space>l", "lua vim.lsp.diagnostic.set_loclist()", opts)
    buf_set_keymap("n", "<space>q", "lua vim.lsp.diagnostic.set_qflist()", opts)
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
end

m.get_capabilities = function()
    return require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
end

local function get_clang_capabilities()
    -- NOTE: Warning will be issued if encoding is not specified.
    local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.offsetEncoding = { "utf-16" }
    return capabilities
end

local function setup_lsp_clangd(serverconfig, on_attach)
    serverconfig.setup({
        on_attach = on_attach,
        capabilities = get_clang_capabilities(),
    })
end

local function setup_lsp_rust_analyzer(serverconfig, on_attach, capabilities)
    serverconfig.setup({
        settings = {
            ["rust-analyzer"] = {
                cargo = {
                    loadOutDirsFromCheck = true,
                },
                procMacro = {
                    enable = true,
                },
                checkOnSave = {
                    command = "clippy",
                },
            },
        },
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

local function setup_lsp_hls(serverconfig, on_attach, capabilities)
    serverconfig.setup({
        settings = {
            haskell = {
                hlintOn = true,
                formattingProvider = "fourmolu",
            },
        },
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

local function setup_lsp_html(serverconfig, on_attach, capabilities)
    serverconfig.setup({
        init_options = {
            provideFormatter = false,
        },
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

local function setup_lsp_jsonls(serverconfig, on_attach, capabilities)
    serverconfig.setup({
        init_options = {
            provideFormatter = false,
        },
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

local function setup_lsp_sumneko_lua(serverconfig, on_attach, capabilities)
    serverconfig.setup({
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                    neededFileStatus = {
                        ["codestyle-check"] = "Any",
                    },
                },
                format = {
                    enable = false,
                },
            },
        },
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

local function setup_lsp_any(serverconfig, on_attach, capabilities)
    serverconfig.setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

m.setup_lsp = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local lspconfig = require("lspconfig")
    local capabilities = m.get_capabilities()
    local on_attach = m.on_attach
    mason.setup()
    mason_lspconfig.setup_handlers({
        function(server_name)
            local serverconfig = lspconfig[server_name]

            if server_name == "clangd" then
                -- c/cpp
                setup_lsp_clangd(serverconfig, on_attach)
            elseif server_name == "rust_analyzer" then
                -- rust
                setup_lsp_rust_analyzer(serverconfig, on_attach, capabilities)
            elseif server_name == "hls" then
                -- haskell
                setup_lsp_hls(serverconfig, on_attach, capabilities)
            elseif server_name == "html" then
                -- html
                setup_lsp_html(serverconfig, on_attach, capabilities)
            elseif server_name == "jsonls" then
                -- json
                setup_lsp_jsonls(serverconfig, on_attach, capabilities)
            elseif server_name == "sumneko_lua" then
                -- lua
                setup_lsp_sumneko_lua(serverconfig, on_attach, capabilities)
            else
                setup_lsp_any(serverconfig, on_attach, capabilities)
            end
        end,
    })
end

m.setup_lspsaga = function()
    require("lspsaga").setup({
        debug = false,
        use_saga_diagnostic_sign = true,
        error_sign = "",
        warn_sign = "",
        hint_sign = "",
        infor_sign = "",
        diagnostic_header_icon = "   ",
        code_action_icon = " ",
        code_action_prompt = {
            enable = true,
            sign = true,
            sign_priority = 40,
            virtual_text = true,
        },
        finder_definition_icon = "  ",
        finder_reference_icon = "  ",
        max_preview_lines = 40,
        finder_action_keys = {
            open = "o",
            vsplit = "s",
            split = "i",
            quit = "q",
            scroll_down = "<C-f>",
            scroll_up = "<C-d>",
        },
        code_action_keys = {
            quit = "q",
            exec = "<CR>",
        },
        rename_action_keys = {
            quit = "<C-c>",
            exec = "<CR>",
        },
        definition_preview_icon = "  ",
        border_style = "single",
        rename_prompt_prefix = "➤",
        server_filetype_map = {},
        diagnostic_prefix_format = "%d. ",
    })
end

m.setup_lsp_color = function()
    require("lsp-colors").setup({
        Error = "#db4b4b",
        Warning = "#e0af68",
        Information = "#0db9d7",
        Hint = "#10B981",
    })
end

m.setup_trouble = function()
    -- Key mappings by default.
    -- close = "q",                 close the list
    -- cancel = "<esc>",            cancel the preview and get back to your last window / buffer / cursor
    -- refresh = "r",               manually refresh
    -- jump = { "<cr>", "<tab>" },  jump to the diagnostic or open / close folds
    -- open_split = { "<c-x>" },    open buffer in new split
    -- open_vsplit = { "<c-v>" },   open buffer in new vsplit
    -- open_tab = { "<c-t>" },      open buffer in new tab
    -- jump_close = { "o" },        jump to the diagnostic and close the list
    -- toggle_mode = "m",           toggle between "workspace" and "document" diagnostics mode
    -- toggle_preview = "P",        toggle auto_preview
    -- hover = "K",                 opens a small popup with the full multiline message
    -- preview = "p",               preview the diagnostic location
    -- close_folds = { "zM", "zm" },close all folds
    -- open_folds = { "zR", "zr" }, open all folds
    -- toggle_fold = { "zA", "za" },toggle fold of current file
    -- previous = "k",              preview item
    -- next = "j"                   next item
    require("trouble").setup({
        height = 10,
        auto_close = true,
        use_diagnostic_signs = true,
    })
end

m.setup_fidget = function()
    require("fidget").setup({
        task = function(task_name, message, percentage)
            return string.format(
                "%s%s [%s]",
                message,
                percentage and string.format(" (%s%%)", percentage) or "",
                task_name
            )
        end,
    })
end

vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<space>a", "<cmd>Lspsaga code_action<CR>", { silent = true, noremap = true })
vim.keymap.set("x", "<space>a", ":<C-u>Lspsaga range_code_action<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true, noremap = true })
vim.cmd([[nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]])
vim.cmd([[nnoremap <silent> <C-d> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]])
vim.keymap.set("n", "<C-k>", "<cmd>Lspsaga signature_help<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<space>r", "<cmd>Lspsaga rename<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<space>d", "<cmd>Lspsaga preview_definition<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<space>e", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true, noremap = true })
vim.keymap.set(
    "n",
    "<space>E",
    [[<cmd>lua require('lspsaga.diagnostic').show_cursor_diagnostics()<CR>]],
    { silent = true, noremap = true }
)
vim.keymap.set("n", "<space>n", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<space>p", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<M-f>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true, noremap = true })
vim.cmd([[tnoremap <silent> <M-f> <C-\><C-n>:Lspsaga close_floaterm<CR>]])
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "gr", "<cmd>Trouble lsp_references<CR>", { silent = true, noremap = true })

return m
