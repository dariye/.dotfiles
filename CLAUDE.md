# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles for Apple Silicon Mac (M1+) running macOS Sonoma or later. Uses RCM for dotfile management, Fish shell with Starship prompt, and mise for runtime version management.

## Architecture

### Dotfile Management Strategy

This repository uses **RCM (rcm)** from thoughtbot for symlink management:
- Files in the repository root (except those in `EXCLUDES`) are symlinked to `$HOME`
- Files in `config/` are symlinked to `$HOME/.config/`
- Configuration is controlled by `rcrc` file

Key RCM commands:
```bash
# Preview what would be symlinked (dry run)
rcup -v

# Create/update symlinks
env RCRC=$HOME/.dotfiles/rcrc rcup

# Show current symlink status
lsrc
```

### Configuration Files Structure

**Core Setup:**
- `mac-setup` - Main setup script for fresh Mac installations
- `Brewfile` - Homebrew packages and casks to install
- `rcrc` - RCM configuration (defines exclusions and dotfiles directory)

**Git Configuration:**
- `gitconfig` - Git user identity and global settings
- `gitignore` - Global git ignore patterns (symlinked to ~/.gitignore)
- `config/git/ignore` - Additional global git ignores (symlinked to ~/.config/git/ignore)

**Shell & Terminal:**
- `config/fish/config.fish` - Fish shell configuration
- `config/starship.toml` - Starship prompt configuration
- `config/atuin/config.toml` - Atuin shell history sync configuration

**Development Tools:**
- `editorconfig` - Cross-editor formatting rules
- `config/gh/config.yml` - GitHub CLI configuration and aliases
- `config/zed/settings.json` - Zed editor settings (MCP servers, themes, LSP)
- `config/zed/keymap.json` - Zed editor custom keybindings

**Runtime Management:**
- `config/mise/config.toml` - mise runtime manager configuration

### Shell Environment

The shell environment is built in layers:

1. **Homebrew** - Installed to `/opt/homebrew` (Apple Silicon path)
2. **Fish Shell** - Set as default shell via `chsh`
3. **Fisher** - Fish plugin manager (auto-installed in config.fish if missing)
4. **Starship** - Cross-shell prompt initialized in fish config
5. **mise** - Runtime manager activated in fish config

### Runtime Management

This repository uses **mise** for polyglot runtime version management:
- `config/mise/config.toml` defines language versions (node, python, ruby, rust, bun, java, etc.)
- `mise.local.toml` exists for machine-specific overrides (ignored by git)
- mise is activated in fish shell via `mise activate fish | source`

## Essential Commands

### Initial Setup

```bash
# Clone repository
git clone git://github.com/dariye/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Make setup executable and run
chmod +x mac-setup
./mac-setup

# Setup dotfiles with RCM
env RCRC=$HOME/.dotfiles/rcrc rcup

# Reload fish configuration
source ~/.config/fish/config.fish
```

### Package Management

```bash
# Install/update all Homebrew packages from Brewfile
brew bundle --file=./Brewfile

# Check what's in Brewfile but not installed
brew bundle check --file=./Brewfile

# Cleanup packages not in Brewfile
brew bundle cleanup --file=./Brewfile
```

### Runtime Management

```bash
# Install all tools defined in mise config
mise install

# List installed versions
mise list

# Check outdated versions
mise outdated

# Add a new tool version
mise use node@latest
```

### Dotfile Management

```bash
# Preview symlinks that would be created
rcup -v

# Update symlinks after adding/removing files
rcup

# Show all managed symlinks
lsrc

# Remove all symlinks
rcdn
```

## Important Constraints

### Apple Silicon Requirements

The `mac-setup` script includes validation:
- **Architecture check**: Must be `arm64` (Apple Silicon)
- **macOS version check**: Must be macOS 14.0 (Sonoma) or later
- Script will exit with error if requirements not met

### Homebrew Paths

Always use `/opt/homebrew` prefix for Apple Silicon, not `/usr/local` (Intel path). The fish config correctly sources:
```fish
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### RCM Exclusions

When adding new files to the repository, remember these are excluded from symlinking (defined in `rcrc`):
- README files
- `.gitignore`, `.git*` files
- `mac-setup`, `Brewfile`, `Brewfile.lock.json`
- `screenshot.png`
- `mise.local.toml`

Files meant to be symlinked should go in repository root (for `$HOME`) or `config/` (for `$HOME/.config/`).

## Development Notes

### Adding New Packages

1. Add to `Brewfile` using format:
   - `brew "package-name"` for CLI tools
   - `cask "app-name"` for GUI applications
2. Run `brew bundle --file=./Brewfile` to install
3. Commit the updated Brewfile

### Adding New Runtimes

1. Edit `config/mise/config.toml`
2. Run `mise install` to install the version
3. Commit the config change
4. Use `mise.local.toml` for machine-specific overrides (not committed)

### Shell Configuration

Fish config auto-installs fisher on first run if missing. When modifying `config/fish/config.fish`:
- Keep `mise activate` line (runtime management)
- Keep `starship init` line (prompt)
- Maintain Homebrew shellenv sourcing
- Be aware of user-specific paths (pnpm, Rancher Desktop, Antigravity, workspace paths)

## Post-Wipe Restoration

### Complete Restoration Procedure

Follow these steps in order after wiping your Mac:

1. **Clone dotfiles repository:**
   ```bash
   git clone git://github.com/dariye/.dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. **Run Mac setup script:**
   ```bash
   chmod +x mac-setup
   ./mac-setup
   ```
   This will install Homebrew, Xcode Command Line Tools, all Brewfile packages, and configure Fish shell.

3. **Setup dotfiles with RCM:**
   ```bash
   env RCRC=$HOME/.dotfiles/rcrc rcup
   ```
   This creates symlinks from the repository to your home directory.

4. **Reload Fish shell:**
   ```bash
   source ~/.config/fish/config.fish
   ```

5. **Install mise tools:**
   ```bash
   mise install
   ```
   Installs all language runtimes defined in `config/mise/config.toml`.

6. **Re-authenticate services:**
   ```bash
   gh auth login    # GitHub CLI authentication
   ```

7. **Verify symlinks:**
   ```bash
   lsrc    # Shows all active symlinks
   ```

### Files Requiring Manual Backup/Restore

These files contain secrets and are NOT tracked in the dotfiles repository. **Back them up securely before wiping:**

**Critical (Work Environment Won't Function Without These):**
- `~/.env` - API keys (GitHub tokens, OpenAI, Perplexity, Braintrust, etc.)
- `~/.ssh/` - SSH keys (backup entire directory)
  - After restore: `chmod 600 ~/.ssh/id_*` to fix permissions
- `~/.aws/` - AWS SSO configuration and credentials
- `~/.kube/config` - Kubernetes cluster access credentials
- `~/.config/gh/hosts.yml` - GitHub CLI authentication tokens (or re-auth with `gh auth login`)

**Optional (Can be regenerated):**
- `~/.docker/config.json` - Docker registry authentication (or re-auth with `docker login`)
- Shell history files (`.local/share/fish/fish_history`, `.zsh_history`)

### Troubleshooting Restoration

**Issue:** Symlinks not created
- Solution: Check `lsrc -v` for dry run, ensure `rcup` completed without errors

**Issue:** GitHub CLI not authenticated
- Solution: Run `gh auth login` and follow prompts

**Issue:** SSH key permissions wrong
- Solution: `chmod 600 ~/.ssh/id_ed25519 && chmod 644 ~/.ssh/id_ed25519.pub`

**Issue:** mise tools not available
- Solution: Ensure `mise activate fish | source` is in Fish config, then run `mise install`
