## Dotfiles - Windows 11

## Installation

> ```powershell
> winget install --id Git.Git -e --source winget
> winget install --id GitHub.cli
> winget install Neovim.Neovim
> winget install GlazeWM
> winget install "Flow Launcher"
> winget install JanDeDobbeleer.OhMyPosh -s winget
> winget install Node.JS
>
> npm install --save-dev --save-exact prettier
>
> scoop bucket add extras
> scoop install neovide
> scoop install extras/yasb
> ```

## Setup-1 Clone Repo and Initialize

> ```powershell
> cd $HOME
> gh repo clone Paperweightt/dotfiles
> .\.dotfiles\init.ps1
> ```

## Setup-2 Manual Setup

```
Flowlauncher
Tridactyl
```

## Neovim Only - Linux

> ```bash
> cd $XDG_CONFIG_HOME
>
> rm nvim -rf
>
> git clone --filter=blob:none --no-checkout https://github.com/Paperweightt/.dotfiles
> cd .dotfiles
> git sparse-checkout init --cone
> git sparse-checkout set nvim
> git checkout
>
> mv nvim ../
> cd ..
> rm .dotfiles -rf
> ```

## Keybinds

[Oryx: The ZSA Keyboard Configurator](https://configure.zsa.io/voyager/layouts/qGely/latest/0)

F19 is used for global keybinds while shift+alt+ctrl is used for per app changes

```
- GlazeWm
  - F19+HJKL           | Move focus
  - F19+Shift+HJKL     | Move focused window
  - F19+yuio           | Move focus to screen 1 2 3 4
  - F19+Shift+yuio     | Move window to screen 1 2 3 4
  - F19+Ctrl+HJKL      | Resize window
  - F19+F              | Toggle window to float
  - F19+T              | Toggle window to tiling
  - F19+M              | Toggle window to maximize
  - F19+N              | Toggle window to minimize
  - F19+A              | Toggle tiling direction
  - F19+Q              | Close window
  - F19+R              | Reload glazeWm config
- Powertoys
  - Ctrl+Shift+C       | Screen color picker
- AutoHotkey
  - global
    - F19+S            | focus or open spotify
    - F19+D            | focus or open discord
    - F19+Z            | focus or open zen browser
    - F19+C            | focus or open neo
  - minecraft
    - Ctrl+F           | Reload minecraft
```

## Alternatives

```
- Neovim - Code editor
  - Visual Studio Code
  - Zed
  - Emacs
  - Helix
- GlazeWm - Windows tiling manager
  - Workspacer
  - Komorebi
- Yasb - Top bar
  - Zebar
- Flow Launcher - Quick launcher
  - PowerToys Run
- Tridactyl - Browser vim keybinds
  - Vimium
  - Vimium C
- Zen - Browser
  - Brave
```

## My Todo List

```
- Missing Info
  - Download
    - Powertoys
  - Configs
    - Flow Launcher
    - Obsidian
- Configure
  - Flow launcher
    - Theme
- Wants
  - Dedicated markdown displayer
```

## Custom Tooling

```
- Neo
  - Launches neovide with .$profile for powershell environment variables
  - Launches from C: drive by default
```

## Sucessful Conversions

- [Sobrukai404](https://github.com/Sobrukai404) | Zen browser
- Grimm | Zen Browser, Neovim
