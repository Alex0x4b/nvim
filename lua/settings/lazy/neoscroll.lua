return {
    "karb94/neoscroll.nvim",
    config = function ()
        require('neoscroll').setup({
            easing = 'cubic',
            cursor_scrolls_alone = false
        })
        local neoscroll = require('neoscroll')
        local keymap = {
            ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 200 }) end;
            ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 200 }) end;
            ["zz"]    = function() neoscroll.zt({ half_win_duration = 200 }) end;
            ["zm"]    = function() neoscroll.zz({ half_win_duration = 200 }) end;
        }
        local modes = { 'n', 'v', 'x' }
        for key, func in pairs(keymap) do
            vim.keymap.set(modes, key, func)
        end
    end
}
