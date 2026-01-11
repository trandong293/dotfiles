return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  config = function()
    local filetypes = {
      "lua",
      "c"
    }
    require("nvim-treesitter").install(filetypes)

    -- features
    -- highlighting
    vim.api.nvim_create_autocmd("FileType", {
      pattern = filetypes,
      callback = function() vim.treesitter.start() end
    })
    -- folding
    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo[0][0].foldmethod = "expr"
    -- indenting
    vim.bo.indentexpr = 'v:lua.require("nvim-treesitter").indentexpr()'
  end
}
