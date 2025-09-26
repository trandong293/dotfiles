return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim"
  },
  opts = {
    --@type lc.lang
    lang = "c"
  }
}
