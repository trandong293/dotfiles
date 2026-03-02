vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro nornu" -- +nu
vim.g.mapleader = " "

vim.o.number = true
vim.o.cursorline = true
vim.o.cursorlineopt = "number"
vim.o.colorcolumn = "81"

local help_nu_aug = vim.api.nvim_create_augroup("HelpNuAug", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  group = help_nu_aug,
  command = "setlocal number"
})

vim.o.wrap = false

vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2

vim.o.foldlevelstart = 99

vim.diagnostic.config({
  severity_sort = true,
  update_in_insert = true,
  virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
  signs = false,
})

vim.filetype.add({ extension = { razor = "razor" } })

require("plugins")
