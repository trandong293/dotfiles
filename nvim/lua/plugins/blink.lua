return {
  "saghen/blink.cmp",
  version = "1.*",
  opts = {
    keymap = {
      preset = "default",
      ["<C-x>"] = { "show", "show_documentation", "hide_documentation" },
      ["<Tab>"] = { "accept", "fallback" },
      ["<Cr>"] = { "accept", "fallback" },
    },
    completion = {
      ghost_text = { enabled = true, show_with_menu = false },
      menu = {
        auto_show = false,
        draw = {
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind" }
          }
        }
      }
    }
  }
}
