return {
    'nvim-lualine/lualine.nvim',
    config = function()
        require('lualine').setup {
            tabline = {
                lualine_a = {'buffers'},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {'tabs'}
            },
            sections = {
                lualine_c = {
                    { 'filename', path = 1 }
                }
            }
        }
    end
}
