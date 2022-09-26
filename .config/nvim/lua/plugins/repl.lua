local m = {}

m.setup = function(use)
    use({
        "michaelb/sniprun",
        run = "bash ./install.sh",
    })
    use("hkupty/iron.nvim")

    m.setup_sniprun()
end

m.setup_sniprun = function()
    require("sniprun").setup()
end

m.setup_iron = function()
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
end

vim.api.nvim_set_keymap("n", "<leader>rr", [[<Cmd>lua require('sniprun').run()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap(
    "x",
    "<leader>cr",
    [[<Cmd>lua require('sniprun').run('v')<CR>]],
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>cc",
    [[<Cmd>lua require('sniprun').reset()<CR>]],
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>cq",
    [[<Cmd>lua require('sniprun.display').close_all()<CR>]],
    { noremap = true, silent = true }
)

return m
