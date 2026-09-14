vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro rnu"
vim.g.mapleader = " "
vim.g.my_group = vim.api.nvim_create_augroup("CustomSettings", { clear = true })

vim.o.number = true
vim.o.relativenumber = true

vim.o.cursorline = true
vim.o.cursorlineopt = "number"

vim.o.colorcolumn = "81"

vim.o.wrap = false

vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.o.foldlevelstart = 99

vim.diagnostic.config({
  severity_sort = true,
  sign = false,
  update_in_insert = true,
  virtual_text = {
    severity = {
      vim.diagnostic.severity.WARN,
      vim.diagnostic.severity.ERROR
    }
  }
})

require("plugins")
