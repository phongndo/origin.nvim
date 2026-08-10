# Contributing

Contributions and bug reports are welcome.

## Requirements

- Neovim 0.9+
- GNU Make
- [StyLua](https://github.com/JohnnyMorganz/StyLua)

## Development

```sh
git clone https://github.com/phongndo/origin.nvim
cd origin.nvim
make test
```

The main implementation files are:

- `lua/origin/palette.lua` — base colors and generated shades
- `lua/origin/groups.lua` — editor, syntax, Tree-sitter, and LSP highlights
- `lua/origin/integrations.lua` — plugin highlights
- `queries/` — language-specific Tree-sitter queries
- `tests/smoke.lua` — automated checks

## Guidelines

- Keep plugin integrations dependency-free; defining a highlight must not require the plugin to be installed.
- Use existing palette values and generated shades before adding colors.
- Preserve readable contrast against the default background.
- Keep Tree-sitter captures primary, LSP semantic tokens compatible, and legacy syntax usable as a fallback.
- Update tests and documentation with behavior changes.
- Run `make extras` after changing the base palette.

## Checks

Run all checks before opening a pull request:

```sh
make format
make test
make check-extras
```

For visual bugs, include the Neovim version, terminal, font, minimal configuration, and a screenshot.
