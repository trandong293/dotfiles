return {
  "rebelot/kanagawa.nvim",
  on_load = function()
    require("kanagawa").setup({
      overrides = function(colors)
        return {
          CursorLineNr = { fg = colors.palette.springGreen, bold = true }
        }
      end
    })

    vim.cmd("colorscheme kanagawa-dragon")
  end
}
