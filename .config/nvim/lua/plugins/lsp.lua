local m = {}

local lib_lsp = require("lib.lsp")

vim.g.Illuminate_delay = 500
vim.g.Illuminate_highlightUnderCursor = 0

g_on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local opts = { noremap = true, silent = true }
    buf_set_keymap("n", "<space>gD", "lua vim.lsp.buf.declaration()", opts)

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

local mason = {
    "williamboman/mason.nvim",
    config = function()
        require("mason").setup({})
    end,
}

function setup_lsp_clangd(serverconfig, on_attach)
    serverconfig.setup({
        on_attach = on_attach,
        capabilities = function()
            local capabilities =
                require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
            capabilities.offsetEncoding = { "utf-16" }
            return capabilities
        end,
    })
end

function setup_lsp_rust_analyzer(serverconfig, on_attach, capabilities)
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

function setup_lsp_hls(serverconfig, on_attach, capabilities)
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

function setup_lsp_html(serverconfig, on_attach, capabilities)
    serverconfig.setup({
        init_options = {
            provideFormatter = false,
        },
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

function setup_lsp_jsonls(serverconfig, on_attach, capabilities)
    serverconfig.setup({
        init_options = {
            provideFormatter = false,
        },
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

function setup_lsp_sumneko_lua(serverconfig, on_attach, capabilities)
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
                    enable = true,
                },
            },
        },
        on_attach = on_attach,
        capabilities = capabilities,
    })
end
function setup_lsp_omnisharp(serverconfig, on_attach, capabilities)
    serverconfig.setup({
        cmd = { "omnisharp" },
        -- enable_editorconfig_support = true,
        -- enable_roslyn_analyzers = true,
        on_attach = on_attach,
        capabilities = capabilities,
    })
end
function setup_lsp_tsserver(serverconfig, on_attach, capabilities)
    local lspconfig = require("lspconfig")
    serverconfig.setup({
        -- Exclude ".git"
        root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

function setup_lsp_denols(serverconfig, on_attach, capabilities)
    local lspconfig = require("lspconfig")
    local stat = vim.loop.fs_stat(vim.fn.expand("deno.json"))
    local has_deno = stat ~= nil and true or false
    serverconfig.setup({
        init_options = {
            enable = has_deno,
            lint = true,
            unstable = false,
        },
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

function setup_lsp_elixirls(serverconfig, on_attach, capabilities)
    local lspconfig = require("lspconfig")
    serverconfig.setup({
        cmd = { "elixir-ls" },
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

function setup_lsp_bash(serverconfig, on_attach, capabilities)
    local lspconfig = require("lspconfig")
    serverconfig.setup({
        cmd = { "bash-language-server" },
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

function setup_lsp_any(serverconfig, on_attach, capabilities)
    serverconfig.setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

local lspconfig = {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local mason_lspconfig = require("mason-lspconfig")
        local lspconfig = require("lspconfig")
        -- local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
        local capabilities = lib_lsp.get_capabilities()
        local on_attach = lib_lsp.on_attach
        mason_lspconfig.setup({})
        mason_lspconfig.setup_handlers({
            ["clangd"] = function()
                setup_lsp_clangd(lspconfig["cland"], on_attach)
            end,
            ["rust_analyzer"] = function()
                setup_lsp_rust_analyzer(lspconfig["rust_analyzer"], on_attach, capabilities)
            end,
            ["omnisharp"] = function()
                setup_lsp_omnisharp(lspconfig["omnisharp"], on_attach, capabilities)
            end,
            ["jdtls"] = function() end,
            function(server_name)
                lspconfig[server_name].setup({ capabilities = capabilities, on_attach = on_attach })
            end,

            -- elseif server_name == "jdtls" then -- jdtls is used by nvim-jdtls elseif server_name == "hls" then
            --     -- haskell
            --     setup_lsp_hls(serverconfig, on_attach, capabilities)
            -- elseif server_name == "html" then
            --     -- html
            --     setup_lsp_html(serverconfig, on_attach, capabilities)
            -- elseif server_name == "jsonls" then
            --     -- json
            --     setup_lsp_jsonls(serverconfig, on_attach, capabilities)
            -- elseif server_name == "lua_ls" then
            --     -- lua
            --     setup_lsp_sumneko_lua(serverconfig, on_attach, capabilities)
            -- elseif server_name == "tsserver" then
            --     -- javascript/typescript/react
            --     setup_lsp_tsserver(serverconfig, on_attach, capabilities)
            -- elseif server_name == "denols" then
            --     -- javascript/typescript/react
            --     setup_lsp_denols(serverconfig, on_attach, capabilities)
            -- elseif server_name == "omnisharp" then
            --     -- csharp
            --     setup_lsp_omnisharp(serverconfig, on_attach, capabilities)
            -- elseif server_name == "elixirls" then
            --     setup_lsp_elixirls(serverconfig, on_attach, capabilities)
            --     --                elseif server_name == "bash" then
            --     --                    setup_lsp_bash(serverconfig, on_attach, capabilities)
            -- else
            --     setup_lsp_any(serverconfig, on_attach, capabilities)
            -- end
        })
    end,
}

local lspsaga = {
    "nvimdev/lspsaga.nvim",
    keys = {
        { mode = "n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true, noremap = true } },
        { mode = "n", "<space>a", "<cmd>Lspsaga code_action<CR>", { silent = true, noremap = true } },
        { mode = "x", "<space>a", ":<C-u>Lspsaga range_code_action<CR>", { silent = true, noremap = true } },
        { mode = "n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true, noremap = true } },
        { mode = "n", "<C-k>", "<cmd>Lspsaga signature_help<CR>", { silent = true, noremap = true } },
        { mode = "n", "<space>r", "<cmd>Lspsaga rename<CR>", { silent = true, noremap = true } },
        { mode = "n", "<space>d", "<cmd>Lspsaga preview_definition<CR>", { silent = true, noremap = true } },
        { mode = "n", "<space>e", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true, noremap = true } },
        {
            mode = "n",
            "<space>E",
            [[<cmd>lua require('lspsaga.diagnostic').show_cursor_diagnostics()<CR>]],
            { silent = true, noremap = true },
        },
        { mode = "n", "<space>n", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true, noremap = true } },
        { mode = "n", "<space>p", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true, noremap = true } },
        { mode = "n", "<M-f>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true, noremap = true } },
    },
    config = function()
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
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter", -- optional
        "nvim-tree/nvim-web-devicons", -- optional
    },
}

local lsp_colors = {
    "folke/lsp-colors.nvim",
    config = function()
        require("lsp-colors").setup({
            Error = "#db4b4b",
            Warning = "#e0af68",
            Information = "#0db9d7",
            Hint = "#10B981",
        })
    end,
}

local trouble = {
    -- {
    --     "folke/trouble.nvim",
    --     dependencies = "nvim-tree/nvim-web-devicons",
    -- },
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
        { mode = "n", "<leader>xx", "<cmd>Trouble<CR>", { silent = true, noremap = true } },
        { mode = "n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<CR>", { silent = true, noremap = true } },
        { mode = "n", "<leader>xd", "<cmd>Trouble document_diagnostics<CR>", { silent = true, noremap = true } },
        { mode = "n", "gr", "<cmd>Trouble lsp_references<CR>", { silent = true, noremap = true } },
    },
    config = function()
        require("trouble").setup({
            height = 10,
            auto_close = true,
            use_diagnostic_signs = true,
        })
    end,
}

local fidget = {
    "j-hui/fidget.nvim",
    config = function()
        require("fidget").setup()
    end,
}

local illuminate = {
    "RRethy/vim-illuminate",
    config = function()
        require("illuminate").configure({
            providers = {
                "lsp",
                "treesitter",
                "regex",
            },
            delay = 500,
            filetypes_denylist = {
                "dirvish",
                "fugitive",
            },
            filetypes_allowlist = {},
            modes_denylist = {},
            modes_allowlist = {},
            providers_regex_syntax_denylist = {},
            providers_regex_syntax_allowlist = {},
            under_cursor = true,
        })
    end,
}

m = {
    --"williamboman/mason.nvim" ,
    mason,
    "hrsh7th/cmp-nvim-lsp",
    lspconfig,
    lspsaga,
    trouble,
    lsp_colors,
    fidget,
    illuminate,
}
vim.cmd([[nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]])
vim.cmd([[nnoremap <silent> <C-d> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]])
vim.cmd([[tnoremap <silent> <M-f> <C-\><C-n>:Lspsaga close_floaterm<CR>]])

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "Fix startup error by disabling semantic tokens for omnisharp",
    group = vim.api.nvim_create_augroup("OmnisharpHook", {}),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client.name == "omnisharp" then
            client.server_capabilities.semanticTokensProvider = nil
        end
    end,
})

return m
