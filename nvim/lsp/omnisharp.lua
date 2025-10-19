return {
  on_init = function(client)
    -- I don't know why omnisharp server does not enable it?
    client.server_capabilities.documentFormattingProvider = true
  end,
}
