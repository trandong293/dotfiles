return {
  "saghen/blink.cmp",
  tag = "v1.8.0",
  config = function()
    require("blink.cmp").setup({
      keymap = {
        preset = "default",
        ["<C-x>"] = { "show", "show_documentation", "hide_documentation" },
        ["<Tab>"] = { "accept", "fallback" },
        ["<Cr>"] = { "accept", "fallback" }
      },
      completion = {
        ghost_text = { enabled = true, show_with_menu = false },
        menu = { auto_show = false }
      }
    })
  end
}
