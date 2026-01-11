return {
  "mason-org/mason.nvim",
  dependencies = { "neovim/nvim-lspconfig" },
  config = function()
    -- 1
    require("mason").setup()

    vim.keymap.set("n", "<leader>sd", vim.diagnostic.open_float)
    vim.keymap.set("n", "K", vim.lsp.buf.hover)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
    vim.keymap.set("n", "go", vim.lsp.buf.type_definition)
    vim.keymap.set("n", "gr", vim.lsp.buf.references)
    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help)
    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename)
    vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action)

    local autoformat = function(buf)
      local autoformat_aug = vim.api.nvim_create_augroup("AutoFormat", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = autoformat_aug,
        buffer = buf,
        callback = function()
          vim.lsp.buf.format()
        end
      })
    end

    local configure_ls_aug = vim.api.nvim_create_augroup("ConfigureLangServers", { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
      group = configure_ls_aug,
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client then
          return
        end
        -- disbale lsp highlight (highlight with treesitter)
        client.server_capabilities.semanticTokensProvider = nil
        -- enable autoformat on save
        if client:supports_method("textDocument/formatting") then
          autoformat(ev.buf)
        end
      end
    })

    -- 2 lang servers
    local lang_servers = {
      "lua-language-server",
      "clangd"
    }

    local not_installed = {}
    local registry = require("mason-registry")
    for _, server in ipairs(lang_servers) do
      if not registry.is_installed(server) then
        table.insert(not_installed, server)
      end
    end
    if #not_installed > 0 then
      vim.cmd("MasonInstall" .. " " .. table.concat(not_installed, " "))
    end

    vim.lsp.enable("lua_ls")
    vim.lsp.enable("clangd")
  end
}
