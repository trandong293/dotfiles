return {
  "mason-org/mason.nvim",
  opts = {},
  config = function()
    require("mason").setup()
    local ensure_installed = {
      "bash-language-server", "shfmt", "shellcheck",
      "lua-language-server",
      "clangd",
      "omnisharp",
      "typescript-language-server", "html-lsp", "superhtml", "css-lsp",
      "angular-language-server",
      "ruff", "zuban",
      "harper-ls",
      "gopls",
      "texlab", "tex-fmt"
    }
    -- only run when add new lsp
    --local registry = require("mason-registry")
    --not_yet_installed = {}
    --for _, v in ipairs(ensure_installed) do
    --  if not registry.is_installed(v) then
    --    not_yet_installed[#not_yet_installed + 1] = v
    --  end
    --end
    --require("mason.api.command").MasonInstall(not_yet_installed)

    -- shfmt and shellcheck are automatically enabled
    -- https://github.com/bash-lsp/bash-language-server?tab=readme-ov-file#dependencies
    vim.lsp.enable("bashls")
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("clangd")
    vim.lsp.enable("omnisharp")
    vim.lsp.enable("ts_ls")
    vim.lsp.enable("html")
    vim.lsp.enable("superhtml")
    vim.lsp.enable("cssls")
    vim.lsp.enable("angularls")
    vim.lsp.enable("ruff")
    vim.lsp.enable("zuban")
    vim.lsp.enable("harper_ls")
    vim.lsp.enable("golsp")
    -- tex-fmt: lspconfig
    vim.lsp.enable("texlab")
  end
}
