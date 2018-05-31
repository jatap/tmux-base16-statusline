#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

theme_option='@base16-statusline'
default_theme='main'
separator_session_name_option='@base16-statusline-separator-session-name'
default_separator_session_name=''
main_separator_option='@base16-statusline-main-separator'
default_main_separator='ﱞ'

get_tmux_option() {
  local option="$1"
  local default_value="$2"
  local option_value="$(tmux show-option -gqv "$option")"

  echo ${option_value:-$default_value}
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

main() {
  separators

  local theme="$(get_tmux_option "$theme_option" "$default_theme")"
  tmux source-file "$CURRENT_DIR/src/${theme}.theme"
}

cleanup() {
  unset -v CURRENT_DIR
  tmux set-option -gqu $separator_session_name_option
  tmux set-option -gqu $main_separator_option
}

main
cleanup
