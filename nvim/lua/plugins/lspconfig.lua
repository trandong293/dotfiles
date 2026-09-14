return {
  "neovim/nvim-lspconfig",
  on_load = function()
    vim.keymap.set("n", "<leader>sd", vim.diagnostic.open_float)
    vim.keymap.set("n", "K", vim.lsp.buf.hover)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition)
    vim.keymap.set("n", "gr", vim.lsp.buf.references)
    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename)

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.g.custom_group,
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client then client.server_capabilities.semanticTokensProvider = nil end
      end
    })

    vim.api.nvim_create_autocmd({ "BufWritePre", "LspAttach" }, {
      group = vim.g.custom_group,
      callback = function()
        vim.lsp.buf.format()
      end
    })

    vim.lsp.config("lua_ls", {
      settings = { Lua = { diagnostics = { globals = { "vim" } } } }
    })

    --vim.lsp.config("angularls", {
    --  root_dir = function(bufnr, on_dir)
    --    local root_markers = vim.lsp.config["angularls"].root_markers
    --    local root_dir = vim.fs.root(bufnr, root_markers)
    --    if root_dir then on_dir(root_dir) end
    --  end
    --})

    local lang_servers = {
      "lua_ls",        -- pm
      "clangd",        -- pm, clang
      "tsc",           -- pnpm
      "cssls", "html", -- pnpm, @t1ckbase/vscode-langservers-extracted
      "gopls",         -- go
      "roslyn",        -- dotnet tool, roslyn plug
      --"angularls",     -- pnpm, painful, conflict with tsc in ts7
      "ruff", "pyrefly",
    }
    vim.lsp.enable(lang_servers)
  end
}
