return {
  "mason-org/mason.nvim",
  dependencies = { "neovim/nvim-lspconfig" },
  config = function()
    -- lsp config
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

    local auto_format = function(buf)
      local format_on_save_aug = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        group = format_on_save_aug,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end
      })
    end

    local configure_ls_aug = vim.api.nvim_create_augroup("ConfigureLS", { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
      group = configure_ls_aug,
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client then return end

        client.server_capabilities.semanticTokensProvider = nil

        if client:supports_method("textDocument/formatting") then
          auto_format(ev.buf)
        end
      end
    })

    -- mason config
    require("mason").setup({
      registries = {
        "github:mason-org/mason-registry",
        "github:crashdummyy/mason-registry",
      }
    })
    local pkgs = {
      "lua-language-server",
      "clangd",
      "roslyn",
      "tsgo", "css-lsp", "html-lsp", "angular-language-server",
    }
    local reg = require("mason-registry")
    local n_ins_pkgs = {}
    reg.refresh(function()
      for _, pkg in ipairs(pkgs) do
        if reg.has_package(pkg) and not reg.is_installed(pkg) then
          table.insert(n_ins_pkgs, pkg)
        end
      end
      if #n_ins_pkgs > 0 then
        vim.cmd("MasonInstall" .. " " .. table.concat(n_ins_pkgs, " "))
      end
    end)

    local lss = {
      "lua_ls",
      "clangd",
      "roslyn_ls",
      "tsgo", "cssls", "html", "angularls",
    }
    vim.lsp.enable(lss)
  end
}
