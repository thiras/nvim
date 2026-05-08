return {
  "stevearc/aerial.nvim",
  opts = {
    open_automatic = true,
    attach_mode = "global",
    layout = {
      default_direction = "right",
      placement = "edge", -- always at the far right of the editor, not adjacent to current window
    },
    backends = {
      ["_"] = { "treesitter", "lsp", "markdown", "man" },
      toml = { "treesitter" }, -- skip LSP entirely, taplo doesn't provide symbols
    },
  },
}
