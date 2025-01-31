# .dotfiles

![Screenshot](/screenshot.png?raw=true "Screenshot")

## Installation


### Getting started

```bash
git clone git://github.com/dariye/.dotfiles.git
```


### Mac setup

```bash
cd ~/dotfiles
./mac-setup

```

### Set up dotfiles manager

This should be run after setup above is complete.

```
env RCRC=$HOME/dotfiles/rcrc rcup
source ~/.config/fish/config.fish
```

## Programs

<details>
    <summary>Terminal</summary>
    <ul>
        <li><a href="https://ghostty.org/">Ghostty</a></li>
    </ul>
    <details>
        <summary>Theme</summary>
        <ul>
            <li><a href="https://www.nordtheme.com/">nord</a></li>
        </ul>
    </details>
</details>

<details>
    <summary>Shell</summary>
    <ul>
        <li><a href="https://fishshell.com/">fish</a> - fisher as pkg manager</li>
        <li><a href="https://starship.rs">starship - </a>shell prompt with <a href="https://starship.rs/presets/pure-preset">pure preset</a></li>
    </ul>
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
