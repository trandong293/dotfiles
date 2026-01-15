local log = {}

local f
local log_path = "/tmp/nvim_debug.log"
local script_path = function() return debug.getinfo(3, "S").source:sub(2) end

log.write = function(...)
  if not f then
    f = io.open(log_path, "a")
  end

  local buf = {}
  for i = 1, select("#", ...) do
    local val = select(i, ...)
    table.insert(buf, vim.inspect(val))
  end

  f:write(
    os.date("%Y-%m-%d %H:%M:%S")
    .. " "
    .. script_path()
    .. "\n"
    .. table.concat(buf, "\n")
    .. "\n\n"
  )
  f:flush()
end

return log
