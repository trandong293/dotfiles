return {
  -- dynamically start angularls, because I don't want it to start
  -- automatically for non-angular project
  root_dir = function(bufnr, on_dir)
    local path = vim.fn.system({ "git", "rev-parse", "--show-toplevel" })
    if string.sub(path, 1, 5) ~= "fatal" then
      if vim.fn.findfile("angular.json", string.sub(path, 1, -2)) ~= "" then
        on_dir(path)
      end
    end
  end
}
