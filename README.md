# .dotfiles

![Screenshot](/screenshot.png?raw=true "Screenshot")

Laptop setup for my Apple Silicon Mac (M1) running macOS Sonoma or later.

## Prerequisites

- Apple Silicon Mac (M1 or later)
- macOS Sonoma or later
- Internet connection

### Getting started

```bash
# clone repository
git clone git://github.com/dariye/.dotfiles.git ~/.dotfiles
cd ~/dotfiles

# make setup script executable
chmod +x mac-setup

# run setup script
./mac-setup

# Setup dotfiles (after mac-setup completes)
env RCRC=$HOME/.dotfiles/rcrc rcup
source ~/.config/fish/config.fish
```


## My programs
Some of these are not installed using the setup script. I install them manually (for now).

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
        <li><a href="https://neovim.io">neovim</a></li>
        <li><a href="https://zed.dev/">zed</a></li>
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
        <li><a href="https://asdf-vm.com">asdf</a></li>
    </ul>
</details>

<details>
    <summary>Dotfile manager</summary>
    <ul>
        <li><a href="http://thoughtbot.github.io/rcm/rcm.7.html)">rcm</a></li>
    </ul>
</details>

<details>
    <summary>Productivity</summary>
    <ul>
        <li><a href="https://www.raycast.com">Raycast</a></li>
    </ul>
</details>
