# Changelog

All notable changes to Origin are documented here. This project follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Neovim screenshot in the README.
- hk pre-commit and pre-push checks with pinned development tools.

### Changed

- Lowered the default `starlight` color from `#F7F4ED` to `#DCD9D2` to improve the distinction between regular and bold text.
- Simplified the README, help file, and contribution guide.

### Fixed

- Passed the repository token to the StyLua action so formatting checks work in private repositories.

### Removed

- Preview scripts and sample files.

## [0.1.0] - 2026-08-09

### Added

- Six-color dark palette with generated UI surfaces and accent shades.
- Tree-sitter, LSP semantic token, and legacy syntax highlights.
- Language-specific Tree-sitter queries for C++, Python, Rust, and Racket.
- Diagnostics, diffs, search, Git, completion, navigation, and editor UI highlights.
- Integrations for common completion, picker, Git, explorer, UI, DAP, Markdown, and AI plugins.
- Lualine theme.
- Terminal themes for Alacritty, foot, Ghostty, iTerm2, Kitty, Konsole, Warp, WezTerm, Windows Terminal, and tmux.
- Health checks, smoke tests, formatting, and CI.

[Unreleased]: https://github.com/phongndo/origin.nvim/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/phongndo/origin.nvim/releases/tag/v0.1.0
