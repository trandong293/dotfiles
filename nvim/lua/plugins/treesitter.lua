return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  config = function()
    langs = { "lua", "c", }
    require("nvim-treesitter").install(langs)
    
    -- highlight
    local ts_hl_aug = vim.api.nvim_create_augroup("TsHlAug", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = langs,
      group = ts_hl_aug,
      callback = function() vim.treesitter.start() end
    })
    -- fold
    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo[0][0].foldmethod = "expr"
    -- indent
    vim.bo.indentexpr = 'v:lua.require("nvim-treesitter").indentexpr()'
  end
}
