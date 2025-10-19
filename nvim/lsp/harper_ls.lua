return {
  -- fix stupid warning spams
  on_init = function(client)
    client.server_capabilities.textDocumentSync.save = false
  end,
}
