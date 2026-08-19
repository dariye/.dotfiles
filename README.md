# .dotfiles

![Screenshot](/screenshot.png?raw=true "Screenshot")

Laptop setup for my Apple Silicon Mac (M-series) running macOS Sonoma or later.

## Prerequisites

- Apple Silicon Mac (M1 or later)
- macOS Sonoma (14.0) or later
- Internet connection

### Getting started

```bash
# clone repository — this repo lives inside ~/workspace, the root that holds
# every project repo (each its own git repo + moi workspace)
git clone git@github.com:dariye/.dotfiles.git ~/workspace/dotfiles
cd ~/workspace/dotfiles

# set your git identity
git config --global user.name "Your Name"
git config --global user.email "you@example.com"

# make setup script executable
chmod +x mac-setup

# run setup script (links dotfiles via rcm, then installs runtimes)
./mac-setup

source ~/.config/fish/config.fish
```

`mac-setup` runs `rcup` itself, before `mise install` — the mise config has to be
linked into `~/.config` before mise can read it.


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
        <li><a href="https://github.com/gastownhall/beads">beads</a> — the memory layer for coding agents (<code>bd</code>), backed by an embedded <a href="https://www.dolthub.com/">Dolt</a> engine (the Brewfile's <code>dolt</code> CLI inspects and backs up the databases; <code>mac-setup</code> sets its commit identity). Per-repo: <code>bd init --stealth</code> + <code>bd setup claude --stealth</code> keep everything out of git via <code>.git/info/exclude</code>, so collaborators never see it. Cross-machine sync via <code>bd dolt push/pull</code> against <code>file://</code> Dolt remotes under <code>~/workspace/.beads-remotes/</code> (carried by Syncthing) — never against work git remotes. Telemetry is disabled globally via <code>config/bd/config.yaml</code>.</li>
        <li><a href="https://moi.computer/">moi</a> — local agent workspace UI, installed globally with bun by <code>mac-setup</code> (not on Homebrew). Runs as a launchd service on <code>localhost:13337</code>; run <code>moi init</code> inside each project repo. <code>config/fish/conf.d/bun.fish</code> puts <code>~/.bun/bin</code> on PATH for it.</li>
    </ul>
</details>
