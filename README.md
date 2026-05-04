# 💤 nvim

Personal Neovim configuration built on [LazyVim](https://github.com/LazyVim/LazyVim).

## Install

```sh
git clone git@github.com:thiras/nvim.git ~/.config/nvim
nvim
```

On first launch, lazy.nvim bootstraps itself, installs every plugin pinned in `lazy-lock.json`, and `:Mason` pulls down LSP servers, formatters, and linters.

## Layout

```
init.lua             entrypoint
lua/config/          lazy.nvim bootstrap + override hooks (options, autocmds, keymaps)
lua/plugins/         custom plugin specs and LazyVim overrides
lazyvim.json         enabled LazyVim "extras" — toggle with :LazyExtras
lazy-lock.json       plugin commit pins
```

## Notable additions on top of LazyVim defaults

- **[claudecode.nvim](https://github.com/coder/claudecode.nvim)** — Claude Code integration, eager-loaded.
- **[image.nvim](https://github.com/3rd/image.nvim)** + **[diagram.nvim](https://github.com/3rd/diagram.nvim)** — inline image and Mermaid rendering in the terminal.
- **[aerial.nvim](https://github.com/stevearc/aerial.nvim)** — symbol outline pinned to the right edge.
- **snacks explorer** tuned to show dotfiles (`.env`, `.env.*`) while keeping gitignored files hidden.
- LazyVim extras for Go, Rust, Python, TypeScript, Terraform, Ansible, Helm, Solidity, SQL, Tailwind, Docker, JSON, YAML, TOML, Markdown.

## External requirements

For the image/diagram pipeline you'll need:

- **[ImageMagick](https://imagemagick.org/)** (`magick` on PATH) — image.nvim uses the `magick_cli` processor.
- **[mermaid-cli](https://github.com/mermaid-js/mermaid-cli)** (`mmdc`) — diagram.nvim shells out to it for rendering.
- A terminal with image protocol support (Kitty graphics or Sixel).

On Ubuntu 23.10+, AppArmor blocks unprivileged user namespaces and breaks puppeteer's Chromium sandbox. `lua/plugins/diagram.lua` writes a puppeteer config that passes `--no-sandbox` to `mmdc` so rendering still works.

## Formatting

Lua sources are formatted with [stylua](https://github.com/JohnnyMorganz/StyLua) (`stylua .`); settings are in `stylua.toml`.
