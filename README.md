# Tmux Base16 Statusline

Tmux statusline based on [base16-shell](https://github.com/chriskempson/base16-shell). This project has been created forking the amazing [tmux-themepack](https://github.com/jimeh/tmux-themepack) tmux plugin.

---

<p align="center"><img src="https://raw.githubusercontent.com/jatap/tmux-base16-statusline/master/src/assets/main.png"/></p>

**Shell's default ANSI colors**: [base16-gruvbox-dark-hard](https://github.com/chriskempson/base16-shell/blob/master/scripts/base16-gruvbox-dark-hard.sh)

---

## Table of Contents

1. [Screenshots](#screenshots)
1. [Nerd Fonts Support](#nerd-fonts-support)
1. [Installation](#installation)
1. [Configuration](#configuration)
1. [Plugin Support](#plugin-support)
1. [TODO](#todo)


## Screenshots

### Base

<p align="center"><img src="https://raw.githubusercontent.com/jatap/tmux-base16-statusline/master/src/assets/header-base.png"/></p>

### Prompt

<p align="center"><img src="https://raw.githubusercontent.com/jatap/tmux-base16-statusline/master/src/assets/header-prompt.png"/></p>

### Copy

<p align="center"><img src="https://raw.githubusercontent.com/jatap/tmux-base16-statusline/master/src/assets/header-copy.png"/></p>

## Nerd Fonts Support

> [Nerd Fonts](http://nerdfonts.com/)

### Font used on the screenshoots

> [Monoid](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Monoid/Retina/complete/Monoid%20Retina%20Nerd%20Font%20Complete.ttf)

## Installation

### Install using [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

1. Add plugin to the list of TPM plugins in `.tmux.conf`:

        set -g @plugin 'jatap/tmux-base16-statusline'

2. Hit `prefix + I` to fetch the plugin and source it. The plugin should now be working.

## Configuration

Select theme via `.tmux.conf` option:

        set -g @base16-statusline 'main'

```<CHAR1>``` can be configured on the ```status-left``` to separate ```session name``` to overwrite its default value:

        set -g @base16-statusline-separator-session-name '@'

```<CHAR2>``` can be configured on the ```status-left``` to separate ```panes number``` and ```active pane``` to overwrite its default value:

        set -g @base16-statusline-main-separator '|'

```<CHAR2>``` can also be used on the ```status-right``` as ```@main_separator```:

        set -g status-right "#{prefix_highlight} #[fg=yellow]%H:%M:%S #[fg=white]#{@main_separator} #[fg=green]%d-%b-%y "

> it's mandatory to add status right on the ~/.tmux.conf file to show prefix_highlight

## Plugin Support

> [tmux-prefix-highlight](https://github.com/tmux-plugins/tmux-prefix-highlight)

Select ```tmux-prefix-highlight``` options via `.tmux.conf`:

        set -g @prefix_highlight_bg black
        set -g @prefix_highlight_fg red
        set -g @prefix_highlight_prefix_prompt '<CHAR3>'
        set -g @prefix_highlight_show_copy_mode 'on'
        set -g @prefix_highlight_copy_prompt '<CHAR4> '
        set -g @prefix_highlight_copy_mode_attr "fg=red,bg=black,bold"
        set -g @prefix_highlight_output_prefix ''
        set -g @prefix_highlight_output_suffix ''

### Characters referenced on the project

Character | Image | Description
--------- | ----- | -----------
`\uf461` | ![char1](https://raw.githubusercontent.com/jatap/tmux-base16-statusline/master/src/assets/char1.png) | `CHAR1` * Used on the ```status-left``` after the ```session-name```
`\ufc5e` | ![char2](https://raw.githubusercontent.com/jatap/tmux-base16-statusline/master/src/assets/char2.png) | `CHAR2` * Used on the ```status-left``` and ```status-right``` as a separator
`\uf6d7` | ![char3](https://raw.githubusercontent.com/jatap/tmux-base16-statusline/master/src/assets/char3.png) | `CHAR3` * Used on the ```@prefix_highlight_prefix_prompt``` option
`\uf0c5` | ![char4](https://raw.githubusercontent.com/jatap/tmux-base16-statusline/master/src/assets/char4.png) | `CHAR4` * Used on the ```@prefix_highlight_copy_prompt``` option


## TODO

- [ ] Move ```status-right``` to the theme
