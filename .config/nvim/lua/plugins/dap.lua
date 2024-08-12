local m = {}
local vsext_path = require("os").getenv("HOME") .. "/dev/vscode"


setup_dap = function()
    require("dap")
    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapLogPoint", { text = "🅻", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "", linehl = "", numhl = "" })
end

setup_dap_ui = function()
    local dapui = require("dapui")
    dapui.setup({
        icons = { expanded = "▾", collapsed = "▸" },
        mappings = {
            expand = { "<CR>", "<2-LeftMouse>" },
            open = "o",
            remove = "d",
            edit = "e",
            repl = "r",
            toggle = "t",
        },
        expand_lines = vim.fn.has("nvim-0.7"),
        layouts = {
            {
                elements = {
                    "scopes",
                    "breakpoints",
                    "stacks",
                    "watches",
                },
                size = 40,
                position = "left",
            },
            {
                elements = {
                    "repl",
                    "console",
                },
                size = 10,
                position = "bottom",
            },
        },
        floating = {
            max_height = nil,
            max_width = nil,
            border = "single",
            mappings = {
                close = { "q", "<Esc>" },
            },
        },
        windows = { indent = 1 },
        render = {
            max_type_length = nil,
        },
    })
    local dap = require("dap")
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
end

setup_dap_virtual_text = function()
    require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = true,
        only_first_definition = true,
        all_references = false,
        filter_references_pattern = "<module",
        virt_text_pos = "eol",
        all_frames = false,
        virt_lines = false,
        virt_text_win_col = nil,
    })
end

setup_dap_telescope = function()
    require("telescope").load_extension("dap")
end

setup_dap_nlua = function()
    local dap = require("dap")
    dap.configurations.lua = {
        {
            type = "nlua",
            request = "attach",
            name = "Attach to running Neovim instance",
            host = function()
                local value = vim.fn.input("Host [127.0.0.1]: ")
                if value ~= "" then
                    return value
                end
                return "127.0.0.1"
            end,
            port = function()
                local val = tonumber(vim.fn.input("Port: "))
                assert(val, "Please provide a port number")
                return val
            end,
        },
    }

    dap.adapters.nlua = function(callback, config)
        callback({ type = "server", host = config.host, port = config.port })
    end
end

setup_dap_python = function()
    local dap_python_adapter_path = require("os").getenv("HOME") .. "/.pyenv/shims/python"
    local dap_python = require("dap-python")
    local dap_python_opts = {
        include_configs = true,
        console = "internalConsole",
        pythonPath = function()
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                -- poetry
                return cwd .. "/.venv/bin/python"
            else
                return dap_python_adapter_path
            end
        end,
    }
    dap_python.setup(dap_python_adapter_path, dap_python_opts)
    dap_python.test_runner = "pytest"
end

setup_dap_ruby = function()
    local dap_ruby = require("dap-ruby")
    -- Port is 38698 by default.
    dap_ruby.setup()
end

setup_dap_php = function()
    local dap = require("dap")
    dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { vsext_path .. "/vscode-php-debug/out/phpDebug.js" },
    }
    dap.configurations.php = {
        {
            type = "php",
            request = "launch",
            name = "Listen for Xdebug",
            -- Xdebug default port.
            port = 9003,
        },
    }
end

setup_dap_javascript_typescript = function()
    local dap = require("dap")
    dap.adapters.node2 = {
        type = "executable",
        command = "node",
        args = { vsext_path .. "/vscode-node-debug2/out/src/nodeDebug.js" },
    }
    dap.adapters.chrome = {
        type = "executable",
        command = "node",
        args = { vsext_path .. "/vscode-chrome-debug/out/src/chromeDebug.js" },
    }
    dap.adapters.firefox = {
        type = "executable",
        command = "node",
        args = { vsext_path .. "/vscode-firefox-debug/dist/adapter.bundle.js" },
    }
    local node2_configuration_javascript = {
        name = "Launch(node)",
        type = "node2",
        request = "launch",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
    }
    local node2_configuration_typescript = {
        name = "Launch(node)",
        type = "node2",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
    }
    local chrome_configuration = {
        name = "Launch(chrome)",
        type = "chrome",
        request = "launch",
        url = "http://localhost:8080",
        webRoot = "${workspaceFolder}/public",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        runtimeExecutable = "/usr/bin/google-chrome-stable",
    }
    dap.configurations.javascript = {
        node2_configuration_javascript,
        chrome_configuration,
    }
    dap.configurations.typescript = {
        node2_configuration_typescript,
        chrome_configuration,
    }
    dap.configurations.javascriptreact = {
        chrome_configuration,
    }
    dap.configurations.vue = dap.configurations.javascriptreact
    dap.configurations.typescriptreact = dap.configurations.javascriptreact
end

setup_dap_go = function()
    local dap_go = require("dap-go")
    dap_go.setup()
end

setup_dap_haskell = function()
    local dap = require("dap")
    dap.adapters.haskell = {
        type = "executable",
        command = "haskell-debug-adapter",
    }
    dap.configurations.haskell = {
        {
            type = "haskell",
            request = "launch",
            name = "Launch",
            workspace = "${workspaceFolder}",
            startup = "${file}",
            stopOnEntry = true,
            logFile = vim.fn.stdpath("data") .. "/haskell-dap.log",
            logLevel = "WARNING",
            ghciEnv = vim.empty_dict(),
            ghciPrompt = "> ",
            ghciInitialPrompt = "> ",
            ghciCmd = "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show",
        },
    }
end

setup_dap_dotnet = function()
    local dap = require("dap")
    dap.adapters.coreclr = {
        type = "executable",
        command = "netcoredbg",
        args = { "--interpreter=vscode" },
    }
    dap.configurations.cs = {
        {
            type = "coreclr",
            name = "Launch",
            request = "launch",
            program = function()
                return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
            end,
        },
    }
end

setup_dap_kotlin = function()
    local dap = require("dap")
    dap.adapters.kotlin = {
        type = "executable",
        command = vsext_path .. "/kotlin-debug-adapter/adapter/build/install/adapter/bin/kotlin-debug-adapter",
        args = { "--interpreter=vscode" },
    }
    dap.configurations.kotlin = {
        {
            type = "kotlin",
            name = "Launch",
            request = "launch",
            projectRoot = vim.fn.getcwd() .. "/app",
            mainClass = function()
                return vim.fn.input("Path to main class: ", "", "file")
            end,
        },
    }
end

setup_dap_lldb = function()
    local dap = require("dap")
    dap.adapters.lldb = {
        type = "executable",
        command = "lldb-vscode",
        name = "lldb",
    }
    dap.configurations.cpp = {
        {
            name = "Launch",
            type = "codelldb",
            request = "launch",
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = {},
        },
        {
            type = "lldb",
            request = "launch",
            name = "Launch (lldb)",
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = {},
        },
    }
    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp
end

setup_dap_load_launchjs = function()
    require("dap.ext.vscode").load_launchjs()
end

vim.api.nvim_set_keymap("n", "<F2>", "<Cmd>lua require'osv'.launch()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F3>", "<Cmd>lua require'osv'.run_this()<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<F4>", "<Cmd>lua require'dap'.disconnect({})<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F5>", "<Cmd>lua require'dap'.continue()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F6>", "<Cmd>lua require'dap'.run_last()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
    "n",
    "<F7>",
    "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<F8>",
    "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<F9>", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F10>", "<Cmd>lua require'dap'.step_over()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F11>", "<Cmd>lua require'dap'.step_into()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-F11>", "<Cmd>lua require'dap'.step_out()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F12>", "<Cmd>lua require'dap'.repl.open()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
    "n",
    "<S-F12>",
    "<Cmd>lua require'dap.ext.vscode'.load_launchjs()<CR>",
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap("n", "<space>u", '<Cmd>lua require("dapui").toggle()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<space>u", '<Cmd>lua require("dapui").eval()<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap(
    "n",
    "<leader>dr",
    "<Cmd>lua require'telescope'.extensions.dap.commands{}<CR>",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>dc",
    "<Cmd>lua require'telescope'.extensions.dap.configurations{}<CR>",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>db",
    "<Cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>dv",
    "<Cmd>lua require'telescope'.extensions.dap.variables{}<CR>",
    { noremap = true, silent = true }
)

m = {
    { "mfussenegger/nvim-dap" },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" },
    },
    { "theHamsta/nvim-dap-virtual-text" },
    { "nvim-telescope/telescope-dap.nvim" },
    { "jbyuki/one-small-step-for-vimkind" },
    { "mfussenegger/nvim-dap-python" },
    { "suketa/nvim-dap-ruby" },
    { "leoluz/nvim-dap-go" },

    config = function()
        setup_dap()
        setup_dap_ui()
        setup_dap_virtual_text()
        setup_dap_telescope()
        setup_dap_nlua()
        setup_dap_python()
        setup_dap_ruby()
        setup_dap_php()
        setup_dap_javascript_typescript()
        setup_dap_go()
        setup_dap_haskell()
        setup_dap_dotnet()
        setup_dap_kotlin()
        setup_dap_lldb()
        setup_dap_load_launchjs()
    end,
}
return m
