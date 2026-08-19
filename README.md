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
linked into `~/.config` before mise can read it. It also bootstraps `~/workspace`
(seed files from `templates/workspace/`, local metadata git repo) — the actual
MOI widgets and beads memory arrive once you pair Syncthing and share the
`workspace-moi` folder.


## The agent's brain

How project knowledge is organized across the AI tools, so every store has one
charter and agents know where to read and write. Inspired by Steve Yegge's
[The Shape of Things to Come](https://yegge.ai/essays/the-shape-of-things-to-come/).

| Store | Charter | Lifetime | How it reaches a session |
|---|---|---|---|
| beads issues (per repo) | Units of work; spec issues carry full implementation detail | Until closed | Loaded by the claimant via `bd` |
| `bd remember` | ≤1-paragraph operational facts and gotchas | Until falsified | Pushed into every session via `bd prime` |
| `.claude/skills/` (per repo) | Procedures for a recurring task type (e.g. `moi-workspace`) | Life of the task type | Auto-loaded on task match |
| `CLAUDE.md` / `AGENTS.md` (per repo, stealth) | Harness ground rules for the repo | Until revised | Read at session start |
| `.moi-objects/` (in `~/workspace`) | The workspace UI itself — widgets, views, dashboards | Until rebuilt | Rendered by the moi server; carried by Syncthing |
| This dotfiles repo | Machine setup + carried harness config (`claude/settings.json`) | Until replaced | Linked by `rcup` |
| `~/.hermes` | Hermes' own scratch memory | Scratch | Hermes only — never canonical; beads is |

Two rules keep this honest: **beads is the single canonical memory** (every
other store is either config, procedure, or scratch), and **memory never
touches work git remotes** (beads syncs via `file://` Dolt remotes under
`~/workspace/.beads-remotes/`, carried by Syncthing).

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
            <li><a href="https://github.com/ajeetdsouza/zoxide">zoxide</a> — smarter cd (<code>z</code>/<code>zi</code>).</li>
            <li><a href="https://github.com/jesseduffield/lazygit">lazygit</a> — git TUI.</li>
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
        <li>Claude Code — global settings travel as <code>claude/settings.json</code> (rcup links it to <code>~/.claude/settings.json</code>); machine-local state (sessions, history) stays out. Global <code>CLAUDE.md</code>, skills, and agents follow the same pattern as they appear.</li>
        <li><a href="https://cursor.com/">Cursor</a> — via the Brewfile cask. Shares each repo's beads memory: <code>bd setup cursor --stealth</code> alongside the claude recipe. Not a moi harness.</li>
        <li><a href="https://github.com/NousResearch/hermes-agent">Hermes Agent</a> — <strong>opt-in, on trial</strong>: <code>./hermes-setup</code> (downloads the installer for review first, then prints the house rules: no messaging gateways on a work machine, <code>~/.hermes</code> is scratch — beads stays the canonical memory, <code>moi init --harness=hermes</code> where it drives a workspace).</li>
    </ul>
</details>
