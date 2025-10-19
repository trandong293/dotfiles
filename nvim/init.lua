-- others
vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro nornu" -- *nu
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.o.number = true
vim.o.wrap = false
vim.o.colorcolumn = "81"
vim.o.cursorline = true
vim.o.cursorlineopt = "number"
-- tab size
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
-- diagnostics
vim.diagnostic.config({
  severity_sort = true,
  update_in_insert = true,
  virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
  signs = false,
})

-- mappings
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

local buffer_autoformat = function(buffer)
  local group = "lsp_autoformat"
  vim.api.nvim_create_augroup(group, { clear = false })
  vim.api.nvim_clear_autocmds({ group = group, buffer = buffer })
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = buffer,
    group = group,
    -- async fail with html end
    callback = function() vim.lsp.buf.format({ async = false }) end
  })
end

-- autocmd
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client == nil then return end
    -- format on save
    if client.supports_method("textDocument/formatting") then
      buffer_autoformat(event.buf)
    end
    -- disable semantic highlights
    client.server_capabilities.semanticTokensProvider = nil
  end
})

-- treesitter
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    "lua",
    "c",
    "c_sharp",
    "python",
    "bash",
    "javascript", "typescript",
    "html",
    "css", "scss",
    "rust",
    "go",
    "htmlangular"
  },
  callback = function()
    vim.treesitter.start()
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
  end,
})

require("config.lazy")
