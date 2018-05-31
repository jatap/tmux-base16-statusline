# Tmux Themepack

A pack of various themes for Tmux.


## Installation

### Install manually

1. Clone repo to local machine:

        git clone https://github.com/jatap/tmux-base16-statusline.git ~/.tmux-base16-statusline

2. Source desired theme in your `~/.tmux.conf`:

        source-file "${HOME}/.tmux-base16-statusline/main.theme"

### Install using [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

1. Add plugin to the list of TPM plugins in `.tmux.conf`:

        set -g @plugin 'jatap/tmux-base16-statusline'

2. Hit `prefix + I` to fetch the plugin and source it. The plugin should now be working.

You can pick and choose a theme via `.tmux.conf` option:

- `set -g @statusline 'main'` (default)
- `...`
