return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install({
      "lua",
      "c",
      "c_sharp",
      "python",
      "bash",
      "javascript", "typescript",
      "html",
      "css", "scss",
      "rust",
      "go",
      "angular",
      "latex", "bibtex",
      "make", "cmake",
    })
  end,
}
