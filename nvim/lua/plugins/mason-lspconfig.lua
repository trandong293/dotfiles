return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = { "mason-org/mason.nvim" },
  config = function()
    require("mason").setup({})
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "clangd",
        "omnisharp",
        "bashls",
        "ts_ls",
        "html", "superhtml",
        "cssls",
        "jedi_language_server", "ruff",
        "harper_ls",
        "angularls",
        "gopls",
        "texlab"
      }
    })
    -- install not a lsp
    local not_lsp = { "shfmt", "shellcheck" }
    local registry = require("mason-registry")
    for _, pkg_name in ipairs(not_lsp) do
      local ok, pkg = pcall(registry.get_package, pkg_name)
      if ok then
        if not pkg:is_installed() then
          pkg:install()
        end
      end
    end
  end
}
