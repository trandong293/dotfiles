return {
  "neovim/nvim-lspconfig",
  -- fucking neovim lsp merge mechanism, that I cannot choose to either override
  -- or extend its default config
  -- files in lsp/ are for extending,
  -- here is used for overriding
  config = function()
    local texlab_cfg = vim.lsp.config.texlab
    texlab_cfg.settings.texlab.latexFormatter = "tex-fmt"
    vim.lsp.config("texlab", texlab_cfg)
  end
}
