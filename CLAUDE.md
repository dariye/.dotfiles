# CLAUDE.md

This file provides guidance to Claude Code when working with this repository.

## Overview

Personal dotfiles for Apple Silicon Mac (M1+) running macOS Sonoma 14.0+ using:
- **RCM** for symlink management
- **Fish** shell with Starship prompt
- **mise** for polyglot runtime version management

## Critical Constraints for Claude Code

### File Placement & Symlinking

RCM automatically symlinks files based on location:
- **Repository root files** → `$HOME` (except EXCLUDES)
- **config/ subdirectory files** → `$HOME/.config/`

**Excluded from symlinking** (defined in `rcrc`):
```
README*.md CLAUDE.md .gitignore LICENSE .git* mac-setup Brewfile
Brewfile.lock.json screenshot.png mise.local.toml
```

When adding new files:
- Place in repository root for `$HOME` symlink
- Place in `config/` for `$HOME/.config/` symlink
- Add to `rcrc` EXCLUDES if file should not be symlinked

### Apple Silicon & Platform Requirements

These constraints are validated in `mac-setup` and must not be changed:
- **Architecture**: `arm64` (Apple Silicon M1+)
- **macOS**: Sonoma 14.0 or later
- **Homebrew prefix**: `/opt/homebrew` (NOT `/usr/local`)

### Shell Configuration Critical Lines

When modifying `config/fish/config.fish`, never remove or break these lines:
```fish
eval "$(/opt/homebrew/bin/brew shellenv)"  # Homebrew environment
starship init fish | source                 # Prompt initialization
mise activate fish | source                 # Runtime manager activation
```

User-specific paths follow these (pnpm, Rancher Desktop, Antigravity, workspace paths).

## Architecture

### File Organization

**Core Setup:**
- `mac-setup` - Installation script (validates Apple Silicon, installs Homebrew, tools, Fish)
- `Brewfile` - Homebrew packages and casks (51 packages)
- `rcrc` - RCM configuration (exclusions, dotfiles directory)

**Configuration Layers:**
- **Git**: `gitconfig`, `config/git/ignore`
- **Shell**: `config/fish/config.fish`, `config/starship.toml`, `config/atuin/config.toml`
- **Tools**: `config/mise/config.toml`, `config/gh/config.yml`, `config/zed/settings.json`
- **Editor**: `editorconfig`

### Environment Initialization

Environment is built in layers (auto-initialized in `config/fish/config.fish`):
```
Homebrew → Fish → Fisher → Starship → mise
```

### Runtime Management

**mise** (`config/mise/config.toml`) manages language versions:
- Defines versions for: node, python, ruby, rust, bun, java, uv, yarn
- Machine-specific overrides go in `mise.local.toml` (git-ignored)
- Activated in Fish shell via `mise activate fish | source`

## Key Implementation Patterns

**Symlink behavior:**
- Configuration files are symlinked from repository to `$HOME/.config/`
- Root files symlinked to `$HOME`
- Exclusions defined in `rcrc` are NOT symlinked

**Secret/local files (git-ignored, not in repository):**
- `mise.local.toml` - Machine-specific runtime overrides
- `.env` - API keys and tokens
- `.ssh/` - SSH keys
- `.aws/` - AWS credentials
- `.kube/config` - Kubernetes credentials

**Brewfile format:**
- `brew "package-name"` for CLI tools
- `cask "app-name"` for GUI applications

**Adding new packages:**
1. Add to `Brewfile` using format above
2. Run `brew bundle --file=./Brewfile` to install

**Adding new runtimes:**
1. Edit `config/mise/config.toml`
2. Run `mise install` to install the version
3. Use `mise.local.toml` for machine-specific overrides (not committed)
