return {
  -- fix stupid warning spams
  on_attach = function(client)
    client.server_capabilities.textDocumentSync.save = false
  end,
}
