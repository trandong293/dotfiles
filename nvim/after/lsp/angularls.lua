return {
  root_dir = function(bufnr, on_dir)
    local root_markers = { "angular.json", "nx.json" }
    local root_dir = vim.fs.root(bufnr, root_markers)
    if root_dir then
      on_dir(root_dir)
    end
  end,
}
