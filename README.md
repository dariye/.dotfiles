# .dotfiles

![Screenshot](/screenshot.png?raw=true "Screenshot")

Laptop setup for my Apple Silicon Mac (M-series) running macOS Sonoma or later.

## Prerequisites

- Apple Silicon Mac (M1 or later)
- macOS Sonoma (14.0) or later
- Internet connection

### Getting started

```bash
# clone repository
git clone git@github.com:dariye/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# git identity is required before Gas Town can initialise beads
git config --global user.name "Your Name"
git config --global user.email "you@example.com"

# make setup script executable
chmod +x mac-setup

# run setup script (links dotfiles via rcm, then installs runtimes)
./mac-setup

source ~/.config/fish/config.fish
```

`mac-setup` runs `rcup` itself, before `mise install` — the mise config has to be
linked into `~/.config` before mise can read it. Set `GT_HQ` to put the Gas Town
HQ somewhere other than `~/gt`.


## My programs
All of these are installed by `mac-setup`, via the Brewfile unless noted.

<details>
    <summary>Terminal</summary>
    <ul>
        <li><a href="https://ghostty.org/">Ghostty</a> with <a href="https://www.nordtheme.com/">Nord theme</a>.</li>
    </ul>
    <details>
        <summary>Shell</summary>
        <ul>
            <li><a href="https://fishshell.com/">Fish</a> with <a href="https://github.com/jorgebucaran/fisher">fisher pkg manager</a>.</li>
            <li><a href="https://starship.rs">Starship</a> with <a href="https://starship.rs/presets/pure-preset">Pure Preset</a>.</li>
        </ul>
    </details>
</details>

<details>
    <summary>Editors</summary>
    <ul>
        <li><a href="https://helix-editor.com/">Helix</a></li>
        <li><a href="https://zed.dev/">Zed</a></li>
    </ul>
    <details>
        <summary>Theme</summary>
        <ul>
            <li><a href="https://www.nordtheme.com/">nord</a></li>
        </ul>
    </details>
</details>

<details>
    <summary>Package managers</summary>
    <ul>
        <li><a href="https://homebrew.sh/">brew</a></li>
        <li><a href="https://mise.jdx.dev">mise</a></li>
    </ul>
</details>

<details>
    <summary>Dotfile manager</summary>
    <ul>
        <li><a href="http://thoughtbot.github.io/rcm/rcm.7.html">rcm</a></li>
    </ul>
</details>

<details>
    <summary>Productivity</summary>
    <ul>
        <li><a href="https://www.raycast.com">Raycast</a></li>
        <li><a href="https://rectangleapp.com/">Rectangle</a></li>
    </ul>
</details>

<details>
    <summary>AI</summary>
    <ul>
        <li><a href="https://ollama.com/">Ollama</a></li>
        <li><a href="https://github.com/steveyegge/gastown">Gas Town</a> — built from source by <code>mac-setup</code> (not on Homebrew). HQ at <code>~/gt</code>, override with <code>GT_HQ</code>. Shell integration for fish lives in <code>config/fish/conf.d/gastown.fish</code>, since upstream only ships bash and zsh.</li>
    </ul>
</details>
