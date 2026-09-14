return {
  "nvim-treesitter/nvim-treesitter",
  build = function() vim.cmd("TSUpdate") end,
  on_load = function()
    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo[0][0].foldmethod = "expr"

    local langs = {
      "lua",
      "c", "asm",
      "markdown", "markdown_inline",
      "typescript", "javascript",
      "html", "css",
      "angular",
      "python",
      "c_sharp",
      "go",
    }

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.g.custom_group,
      pattern = langs,
      callback = function() vim.treesitter.start() end
    })

    require("nvim-treesitter").install(langs)
  end
}
