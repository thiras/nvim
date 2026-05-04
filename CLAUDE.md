# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A personal [LazyVim](https://github.com/LazyVim/LazyVim) configuration for Neovim. The repo lives at `~/.config/nvim` and is loaded directly by `nvim`; there is no build, test, or CI pipeline.

## Common operations

- **Format Lua**: `stylua .` (config in `stylua.toml`: 2-space indent, 120 column width). Run before committing changes to any `.lua` file.
- **Sync plugins**: open Neovim and run `:Lazy sync` (or `:Lazy update`, `:Lazy install`). This rewrites `lazy-lock.json` — commit that file alongside plugin changes.
- **Manage LSPs/formatters/linters**: `:Mason` inside Neovim.
- **Reload after editing config**: restart Neovim. Some edits also need `:Lazy reload <plugin>` to pick up `opts` changes without a restart.
- **Health checks** when something breaks: `:checkhealth lazy`, `:checkhealth lazyvim`, `:checkhealth <plugin>`.

There are no tests. "Verifying" a change means launching `nvim`, exercising the affected feature, and checking `:messages` / `:Lazy log` for errors.

## Architecture

LazyVim is a distribution that ships an opinionated plugin set on top of [lazy.nvim](https://github.com/folke/lazy.nvim). This repo is the standard starter layout:

```
init.lua                  → require("config.lazy")
lua/config/lazy.lua       → bootstraps lazy.nvim, imports LazyVim, then imports lua/plugins/*
lua/config/{options,autocmds,keymaps}.lua  → user override hooks (currently empty stubs)
lua/plugins/*.lua         → plugin specs; each file returns one or more lazy.nvim spec tables
lazyvim.json              → which LazyVim "extras" (curated plugin bundles) are enabled
lazy-lock.json            → exact commit pins for every plugin (machine-generated)
```

### Two ways to add or change plugins

1. **LazyVim extras** — curated bundles like `lazyvim.plugins.extras.lang.go`. Toggle them with `:LazyExtras` (which edits `lazyvim.json`) rather than hand-editing the file. The currently enabled set covers most languages this user works with (Go, Rust, Python, TypeScript, Terraform, Ansible, Helm, Solidity, SQL, Tailwind, etc.) plus the `claudecode` AI extra.
2. **Custom specs in `lua/plugins/`** — every file is auto-imported. To override a LazyVim-provided plugin, return a spec with the same plugin name and an `opts` table; lazy.nvim merges it with the upstream spec. Existing examples to model new overrides on: `snacks.lua` (deep-merges picker source config), `aerial.lua` (overrides defaults), `nvim-lint.lua` (clears markdown linters).

### Loading order

`lua/config/options.lua` runs **before** lazy.nvim startup; `autocmds.lua` and `keymaps.lua` run on the `VeryLazy` event. Defaults from LazyVim are always applied — these files only need to contain *additions* or *overrides*. The stub comments in each file link to the upstream defaults.

### `lua/plugins/example.lua`

This file is a LazyVim-provided cookbook of override patterns and is intentionally inert (`if true then return {} end` at the top). Don't delete it — read it for examples when adding new plugin overrides. Don't add new working specs to it; create a new file in `lua/plugins/` instead.

## Environment-specific quirks worth knowing

- **`lua/plugins/diagram.lua`** writes a puppeteer config to `stdpath("cache")/mermaid-puppeteer.json` with `--no-sandbox` because Ubuntu 23.10+ AppArmor blocks unprivileged user namespaces, which breaks `mmdc`'s Chromium sandbox. If you change diagram rendering, preserve this workaround or mermaid rendering will silently fail.
- **`lua/plugins/image.lua`** sets `processor = "magick_cli"` and `build = false` to avoid building the magick rock (see image.nvim issue #91). Requires the `magick` CLI on PATH.
- **`lua/plugins/snacks.lua`** customizes the file explorer to show dotfiles (e.g. `.env`) but keep gitignored files hidden, with `.git/` always excluded. Note the inverted semantics: `hidden = true` shows dotfiles; `ignored = false` hides gitignored files.
- **`lua/plugins/claudecode.lua`** sets `lazy = false` and `auto_start = true` so the Claude Code integration is live from startup rather than waiting on a keybinding.
