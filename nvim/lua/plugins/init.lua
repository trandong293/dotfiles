-- https://github.com/neovim/neovim/issues/34775
--local log = require("log")

local github_url_mapping = function(name) return "https://github.com/" .. name end
local plugin_raw_handler = function(plugin_raw)
  if type(plugin_raw) == "string" then
    return { src = github_url_mapping(plugin_raw) }
  end
  return {
    src = github_url_mapping(plugin_raw[1]),
    name = plugin_raw[1],
    version = plugin_raw.branch,
    data = {
      build = plugin_raw.build,
      config = plugin_raw.config,
    }
  }
end

local plugins_path = vim.fn.stdpath("config") .. "/lua/plugins/"
local plugin_require = function(fname) return dofile(plugins_path .. fname) end

local plugins = {}
local dep_plugins = {}
for fname, ftype in vim.fs.dir(plugins_path) do
  if ftype == "file" and fname:match("%.lua$") and fname ~= "init.lua" then
    local plugin_raw = plugin_require(fname)
    table.insert(plugins, plugin_raw_handler(plugin_raw))

    local deps = plugin_raw.dependencies
    if deps then
      for _, dep in ipairs(deps) do
        table.insert(dep_plugins, plugin_raw_handler(dep))
      end
    end
  end
end

local pack_changed_hook = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if kind == "install" or kind == "update" then
    local build_task = (ev.data.spec.data or {}).build
    if not build_task then
      return
    end
    --log:write("build", ev)
    local btype = type(build_task)
    if btype == "function" then
      vim.cmd.packadd(name)
      pcall(build_task)
      --log:write("build using lua function")
    elseif build_task:sub(1, 1) == ":" then
      vim.cmd.packadd(name)
      vim.cmd(build_task:sub(2))
      --log:write("build using editor command")
    else
      local path = ev.data.path
      --log:write("build " .. name .. " at " .. path .. " with " .. build_task)
      vim.system({ "sh" }, { stdin = build_task, cwd = path }):wait()
    end
  else -- kind == "delete"
    -- delete flow: remove plug from vim.pack.add (disable), :restart buffer if
    --  exist, vim.pack.del
    -- remove all dependencies:
    --  deps tree to avoid remove inuse deps
    --  data field missing on delete
  end
  --log:write("packchanged", ev, ev.data.spec.data or {})
end

local pack_rebuild_aug = vim.api.nvim_create_augroup("PackRebuild", { clear = true })
vim.api.nvim_create_autocmd("PackChanged", { group = pack_rebuild_aug, callback = pack_changed_hook })

local load_hook = function(plug_data)
  local name, data = plug_data.spec.name, plug_data.spec.data or {}
  vim.cmd.packadd(name)
  if data.config then data.config() end
end

vim.pack.add(dep_plugins, { load = load_hook, confirm = true })
vim.pack.add(plugins, { load = load_hook, confirm = true })
