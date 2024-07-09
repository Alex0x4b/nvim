return {
  "karb94/neoscroll.nvim",
  config = function ()
    require('neoscroll').setup({
        easing = 'cubic'

    })
    require('neoscroll').scroll(
        30, {move_cursor=true, duration=100}
    )
  end
}
