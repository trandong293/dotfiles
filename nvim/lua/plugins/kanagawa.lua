return {
  "rebelot/kanagawa.nvim",
  config = function()
    require("kanagawa").setup({
      overrides = function(colors)
        local theme = colors.theme
        return {
          -- dark completion popup menu
          -- add `blend = vim.o.pumblend` to enable transparency
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, },
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2, },
          PmenuSbar = { bg = theme.ui.bg_m1, },
          PmenuThumb = { bg = theme.ui.bg_p2, }
        }
      end
    })
    vim.cmd("colorscheme kanagawa-dragon")
  end,
}
