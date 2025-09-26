vim.o.shiftwidth = 4
vim.o.tabstop = 4

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local omni_ex = require("omnisharp_extended")
    vim.keymap.set("n", "gd", omni_ex.lsp_definition)
    vim.keymap.set("n", "gi", omni_ex.lsp_implementation)
    vim.keymap.set("n", "go", omni_ex.lsp_type_definition)
    vim.keymap.set("n", "gr", omni_ex.lsp_references)
  end
})
