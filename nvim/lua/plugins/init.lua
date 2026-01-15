local log = require("log")
log.write("-----------------")

local plug_reader = function(raw)
  if type(raw) == "string" then
    return { src = "https://github.com/" .. raw }
  end
  return {
    src = "https://github.com/" .. raw[1],
    version = raw.branch or raw.tag,
    dependencies = raw.dependencies,
    data = {
      build = raw.build,
      config = raw.config
    }
  }
end
local path = vim.fn.stdpath("config") .. "/lua/plugins"
local files = vim.fn.readdir(path)
local plug_specs = {}
for _, file in ipairs(files) do
  if file:match(".lua$") and file ~= "init.lua" then
    local raw = dofile(path .. "/" .. file)
    table.insert(plug_specs, plug_reader(raw))
  end
end

--print(vim.inspect(plug_specs))

local dep_plug_specs = {}
for _, plug_spec in ipairs(plug_specs) do
  local deps = plug_spec.dependencies
  if deps then
    for _, dep in ipairs(deps) do
      table.insert(dep_plug_specs, plug_reader(dep))
    end
    plug_spec.dependencies = nil
  end
end

--print(vim.inspect(dep_plug_specs))
--print(vim.inspect(plug_specs))

local change_hook = function(ev)
  local kind = ev.data.kind
  if kind == "install" or kind == "update" then
    local build = (ev.data.spec.data or {}).build
    if build then
      local name = ev.data.spec.name
      if build:sub(1, 1) == ":" then -- user defined command
        local ud_cmd = build:sub(2)
        --log.write("build udc", ud_cmd)
        vim.cmd.packadd(name)
        vim.cmd(ud_cmd)
      else -- make
        local path = ev.data.path
        local cmd = "cd " .. path .. " && " .. build
        --log.write("build make", cmd)
        vim.fn.system(cmd)
      end
    end
  else -- kind == "delete"
  end
end
local change_hook_aug = vim.api.nvim_create_augroup("ChangeHookAug", { clear = true })
vim.api.nvim_create_autocmd("PackChanged", {
  group = change_hook_aug, callback = change_hook
})

local load_hook = function(plug_data)
  local name = plug_data.spec.name
  vim.cmd.packadd(name)
  local config = (plug_data.spec.data or {}).config
  if config then
    config()
  end
end
vim.pack.add(dep_plug_specs, { load = load_hook, confirm = true })
vim.pack.add(plug_specs, { load = load_hook, confirm = true })
