return {
  cmd = {
    "roslyn",
    "--logLevel",
    "Information",
    "--extensionLogDirectory",
    vim.fs.joinpath(vim.uv.os_tmpdir(), "roslyn_ls/logs"),
    "--stdio",
  },
}
