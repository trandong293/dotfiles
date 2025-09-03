return {
  -- html formatting style conflict with superhtml style.
  -- The former adds some blank lines between head and body tags, while the
  -- latter removes all those lines but keeps the cursor on the current line.
  -- As a result, the cursor moves upward indefinitely.
  -- fix: disable one of the two formatting capabilities
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
}
