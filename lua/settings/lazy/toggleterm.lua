return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
        require("toggleterm").setup{
            open_mapping = [[<C-\>]],
            direction = 'float',
            auto_scroll = true,
            close_on_exit = true
        }
    end
}
