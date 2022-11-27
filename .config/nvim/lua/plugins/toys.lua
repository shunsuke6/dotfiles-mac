local m = {}

m.setup = function(use)
    use({ "shunsuke6/nvim-yoshi", opt = true, cmd = { "YoshiEnable" } })
end

return m
