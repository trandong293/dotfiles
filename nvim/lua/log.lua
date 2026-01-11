-- debug only
return {
  log_path = "/tmp/nvim_debug.log",
  is_log_table = true,
  write = function(self, ...)
    if not self.is_log_table then
      error("please call `log:write`")
    end

    if not self.f then
      self.f = io.open(self.log_path, "a")
    end

    local buf = {}
    for i = 1, select("#", ...) do
      local v = select(i, ...)
      table.insert(buf, vim.inspect(v))
    end

    self.f:write(
      os.date("%Y-%m-%d %H:%M:%S")
      .. " "
      .. debug.getinfo(1, "S").source:sub(2)
      .. "\n"
      .. table.concat(buf, "\n")
      .. "\n\n"
    )
    self.f:flush()
  end
}
