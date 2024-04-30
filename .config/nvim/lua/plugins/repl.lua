local m = {}

m = {
    sniprun,
    iron,
}

sniprun = 
{
    "michaelb/sniprun",
    build = "bash ./install.sh",
    key = {

        { mode = "n", "<leader>rr", [[<Cmd>lua require('sniprun').run()<CR>]], { noremap = true, silent = true } },
        {
            mode = "x",
            "<leader>cr",
            [[<Cmd>lua require('sniprun').run('v')<CR>]],
            { noremap = true, silent = true },
        },
        {
            mode = "n",
            "<leader>cc",
            [[<Cmd>lua require('sniprun').reset()<CR>]],
            { noremap = true, silent = true },
        },
        {
            mode = "n",
            "<leader>cq",
            [[<Cmd>lua require('sniprun.display').close_all()<CR>]],
            { noremap = true, silent = true },
        },
    },
    config = function()
        require("sniprun").setup()
    end,
}

iron = {
    "hkupty/iron.nvim",
    config = function()
        local iron = require("iron.core")
        iron.setup({
            config = {
                repl_definition = {
                    sh = {
                        command = { "zsh" },
                    },
                },
                repl_open_cmd = require("iron.view").curry.right(50),
            },
            keymaps = {
                send_motion = "<leader>rs",
                visual_send = "<leader>rs",
                send_line = "<leader>rl",
                repeat_cmd = "<leader>r.",
                cr = "<leader>r<cr>",
                interrupt = "<leader>r<space>",
                exit = "<leader>rq",
                clear = "<leader>rc",
            },
        })
    end,
}

return m
