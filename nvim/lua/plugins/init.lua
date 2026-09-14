local plug_path = vim.fn.stdpath("config") .. "/lua/plugins"
local dep_specs = {}
local plug_specs = {}

local gh = function(x) return "https://github.com/" .. x end

for fname, ftype in vim.fs.dir(plug_path) do
  if fname ~= "init.lua" then
    local plug_name = "plugins." .. fname:sub(0, -5)
    local plug = require(plug_name)

    table.insert(plug_specs, {
      src = gh(plug[1]),
      version = plug["version"],
      data = { build = plug["build"], on_load = plug["on_load"] }
    })

    if plug["deps"] then
      for _, dep in ipairs(plug.deps) do
        table.insert(dep_specs, {
          src = gh(dep[1] or dep),
          version = dep["version"],
          data = { build = dep["build"] }
        })
      end
      plug.deps = nil
    end
  end
end

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local kind = ev.data.kind
    if kind == "install" or kind == "update" then
      local build = ev.data.spec.data["build"]
      if build then
        if type(build) == "string" then
          vim.system({ build }, { cwd = ev.data.path })
        elseif type(build) == "function" then
          vim.cmd.packadd(ev.data.spec.name)
          build()
        end
      end
    end
  end
})

local on_load_hook = function(plug_data)
  vim.cmd.packadd(plug_data.spec.name)
  local on_load = plug_data.spec.data["on_load"]
  if on_load then on_load() end
end

vim.pack.add(dep_specs, { load = on_load_hook })
vim.pack.add(plug_specs, { load = on_load_hook })
