#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

theme_option='@base16-statusline'
default_theme='main'
separator_session_name_option='@base16-statusline-separator-session-name'
default_separator_session_name=''
main_separator_option='@base16-statusline-main-separator'
default_main_separator='ﱞ'
mode_prefix_prompt_option='@base16-statusline-mode-prefix-prompt'
default_mode_prefix_prompt='   '
mode_copy_prompt_option='@base16-statusline-mode-copy-prompt'
default_mode_copy_prompt='   '
mode_sync_prompt_option='@base16-statusline-mode-sync-prompt'
default_mode_sync_prompt='   '
mode_empty_prompt_option='@base16-statusline-mode-empty-prompt'
default_mode_empty_prompt='   '
pane_zoomed_prompt_option='@base16-statusline-pane-zoomed-prompt'
default_pane_zoomed_prompt='   '

get_tmux_option() {
  local option="$1"
  local default_value="$2"
  local option_value="$(tmux show-option -gqv "$option")"

  echo "${option_value:-$default_value}"
}

set_tmux_option() {
  local option="$1"
  local option_value="$2"
  tmux set-option -gq "$option" "$option_value"
}

separators() {
  local separator_session_name="$(get_tmux_option "$separator_session_name_option" "$default_separator_session_name")"
  set_tmux_option @separator_session_name "$separator_session_name"

  local main_separator="$(get_tmux_option "$main_separator_option" "$default_main_separator")"
  set_tmux_option @main_separator "$main_separator"
}

modes() {
  local mode_prefix_prompt="$(get_tmux_option "$mode_prefix_prompt_option" "$default_mode_prefix_prompt")"
  set_tmux_option @mode_prefix_prompt "$mode_prefix_prompt"

  local mode_copy_prompt="$(get_tmux_option "$mode_copy_prompt_option" "$default_mode_copy_prompt")"
  set_tmux_option @mode_copy_prompt "$mode_copy_prompt"

  local mode_sync_prompt="$(get_tmux_option "$mode_sync_prompt_option" "$default_mode_sync_prompt")"
  set_tmux_option @mode_sync_prompt "$mode_sync_prompt"

  local mode_empty_prompt="$(get_tmux_option "$mode_empty_prompt_option" "$default_mode_empty_prompt")"
  set_tmux_option @mode_empty_prompt "$mode_empty_prompt"
}

zoom() {
  local pane_zoomed_prompt="$(get_tmux_option "$pane_zoomed_prompt_option" "$default_pane_zoomed_prompt")"
  set_tmux_option @pane_zoomed_prompt "$pane_zoomed_prompt"
}

main() {
  separators
  modes
  zoom
  load_theme
}

cleanup() {
  unset -v CURRENT_DIR
  tmux set-option -gqu "$separator_session_name_option"
  tmux set-option -gqu "$main_separator_option"
  tmux set-option -gqu "$mode_prefix_prompt_option"
  tmux set-option -gqu "$mode_copy_prompt_option"
  tmux set-option -gqu "$mode_sync_prompt_option"
  tmux set-option -gqu "$mode_empty_prompt_option"
  tmux set-option -gqu "$pane_zoomed_prompt_option"
}

load_theme() {
  local theme="$(get_tmux_option "$theme_option" "$default_theme")"

  while IFS='=' read -r key val; do
    [ "${key##\#*}" ] || continue
    eval "local $key"="$val"
  done <"$CURRENT_DIR/src/${theme}.colors"

  # Window status alignment
  tmux set -g status-justify centre

  # Dim inactive panes
  tmux set -g window-active-style "bg=${theme_dark_1}"
  tmux set -g window-style "bg=${theme_dark_2},dim"

  # Pane border
  tmux set -g pane-border-style "fg=${theme_dark_1},bg=${theme_dark_2}"
  tmux set -g pane-active-border-style "fg=${theme_status},bg=${theme_dark_1}"
  tmux set -g pane-border-lines double
  tmux set -g pane-border-indicators arrows
  tmux set -g pane-border-status off

  # Pane number indicator
  tmux set -g display-panes-colour "${theme_red}"
  tmux set -g display-panes-active-colour "${theme_magenta}"

  # Status update interval
  tmux set -g status-interval 1

  # Basic status bar colors
  tmux set -g status-style "fg=${theme_fg},bg=${theme_status}"

  # Left side of status bar
  tmux set -g status-left-style "bg=${theme_status_sides}"
  tmux set -g status-left-length 40
  tmux set -g status-left " #S #[fg=${theme_gray}]#{@separator_session_name} #[fg=${theme_yellow}]#I #[fg=${theme_fg}]#{@main_separator} #[fg=${theme_cyan}]#P "

  # Right side of status bar
  local status_right_style="#[fg=${theme_red},bg=${theme_status_sides}]"
  tmux set -g status-right-style "$status_right_style"
  tmux set -g status-right-length 60

  # Modes
  local mode_style="#[fg=${theme_bg},bg=${theme_cyan}]"
  local mode_prompt="${mode_style}#{?client_prefix,#{@mode_prefix_prompt},#{?pane_in_mode,#{@mode_copy_prompt},#{?pane_synchronized,#{@mode_sync_prompt},#{@mode_empty_prompt}}}}$status_right_style"
  local pane_zoomed_style="#[fg=${theme_bg},bg=${theme_yellow}]"
  local pane_zoom_prompt="${pane_zoomed_style}#{?window_zoomed_flag,#{@pane_zoomed_prompt},}$status_right_style"
  tmux set -g status-right "$pane_zoom_prompt$mode_prompt #[fg=${theme_fg}]%H:%M:%S #[fg=${theme_gray}]#{@main_separator} #[fg=${theme_pink}]%d-%b-%y "
  tmux set -g mode-style "${mode_style}"

  # Window status
  tmux set -g window-status-format " #I:#W#F "
  tmux set -g window-status-current-format " #I:#W#F "
  tmux set -g window-status-current-style "fg=${theme_black},bg=${theme_red}"
  tmux set -g window-status-style "fg=${theme_gray},bg=${theme_dark_2},italics"
  tmux set -g window-status-activity-style "fg=${theme_fg},bg=${theme_bg}"
  tmux set -g window-status-separator ""

  # Clock mode
  tmux set -g clock-mode-colour "$theme_red"
  tmux set -g clock-mode-style 24

  # Message
  tmux set -g message-style "fg=${theme_dark_1},bg=${theme_red}"
  tmux set -g message-command-style "fg=${theme_dark_1},bg=${theme_pink}"
}

main
cleanup
