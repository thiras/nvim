return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          hidden = true, -- show dotfiles like .env
          ignored = false, -- keep gitignored files hidden
          exclude = { ".git" }, -- but always hide .git/
          include = { ".env", ".env.*" }, -- force-show these even if gitignored
        },
      },
    },
  },
}
