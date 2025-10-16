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
      "ruff", "zuban", "pyrefly", "jedi-language-server",
      "harper-ls",
      "gopls",
      "texlab", "tex-fmt",
      "rust-analyzer"
    }
    local registry = require("mason-registry")
    local not_yet_installed = {}
    for _, v in ipairs(ensure_installed) do
      if not registry.is_installed(v) then
        not_yet_installed[#not_yet_installed + 1] = v
      end
    end
    if #not_yet_installed > 0 then
      require("mason.api.command").MasonInstall(not_yet_installed)
    end

    vim.lsp.enable("bashls") -- shfmt and shellcheck are automatically enabled
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
    --vim.lsp.enable("pyrefly")
    --vim.lsp.enable("jedi_language_server")
    vim.lsp.enable("harper_ls")
    vim.lsp.enable("gopls")
    vim.lsp.enable("texlab") -- tex-fmt: set via vim.lsp.config
    vim.lsp.enable("rust_analyzer")
  end
}
