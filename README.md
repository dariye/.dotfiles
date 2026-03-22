# .dotfiles

![Screenshot](/screenshot.png?raw=true "Screenshot")

Laptop setup for my Apple Silicon Mac (M-series) running macOS Sonoma or later.

## Prerequisites

- Apple Silicon Mac (M1 or later)
- macOS Sonoma (14.0) or later
- Internet connection

## Getting started

```bash
# 1. Clone
git clone git://github.com/dariye/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# 2. Run system setup (installs Homebrew, packages, runtimes)
chmod +x mac-setup
./mac-setup

# 3. Symlink dotfiles into place
env RCRC=$HOME/.dotfiles/rcrc rcup

# 4. Reload shell
exec fish
```

### What happens

1. **`mac-setup`** installs Homebrew, runs `brew bundle` (Brewfile), sets fish as default shell, installs language runtimes via mise, and installs Gas Town.
2. **`rcup`** symlinks config files into `$HOME` (fish config, starship, mise, gitignore, Claude Code settings, etc.). See `rcrc` for exclusions.
3. **Fish shell** auto-bootstraps Fisher on first launch and installs plugins from `fish_plugins`.

### Re-running

`mac-setup` is idempotent. `brew bundle --no-upgrade` only installs missing packages. `rcup` can be re-run safely to pick up new dotfiles.

## What's included

| Category | Tools |
|----------|-------|
| Shell | [Fish](https://fishshell.com/) + [Fisher](https://github.com/jorgebucaran/fisher) + [Starship](https://starship.rs) (Pure preset) |
| Terminal | [Ghostty](https://ghostty.org/) with Nord theme |
| Editors | [Helix](https://helix-editor.com/) (aliased as vim/vi), [Zed](https://zed.dev/) |
| Runtimes | Ruby, Node, Python, Go, Rust, Bun, Java (via [mise](https://mise.jdx.dev)) |
| Databases | PostgreSQL 16 + 18 (via mise), [Dolt](https://www.dolthub.com/) |
| AI/Dev | [Claude Code](https://claude.ai/), [Beads](https://beads.dev/) (issue tracking), [Ollama](https://ollama.ai/) |
| Infra | Docker, AWS CLI, Temporal, Kubernetes (minikube/kubectx), Flux |
| Packages | [Homebrew](https://brew.sh/), [mise](https://mise.jdx.dev), [rcm](http://thoughtbot.github.io/rcm/rcm.7.html) (dotfile manager) |
| Productivity | [Raycast](https://www.raycast.com), [Rectangle](https://rectangleapp.com/), [Atuin](https://atuin.sh/) (shell history) |
