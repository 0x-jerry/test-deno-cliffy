#!/usr/bin/env zsh
# zsh completion support for tt vv1.0.0

autoload -U is-at-least

# shellcheck disable=SC2154
(( $+functions[__tt_complete] )) ||
function __tt_complete {
  local name="$1"; shift
  local action="$1"; shift
  integer ret=1
  local -a values
  local expl lines
  _tags "$name"
  while _tags; do
    if _requested "$name"; then
      # shellcheck disable=SC2034
      lines="$(tt completions complete "${action}" "${@}")"
      values=("${(ps:\n:)lines}")
      if (( ${#values[@]} )); then
        while _next_label "$name" expl "$action"; do
          compadd -S '' "${expl[@]}" "${values[@]}"
        done
      fi
    fi
  done
}

# shellcheck disable=SC2154
(( $+functions[_tt] )) ||
function _tt() {
  local state

  function _commands() {
    local -a commands
    # shellcheck disable=SC2034
    commands=(
      'completions:Generate shell completions.'
    )
    _describe 'command' commands
    __tt_complete script script 
  }

  function _command_args() {
    case "${words[1]}" in
      completions) _tt_completions ;;
    esac
  }

  _arguments -w -s -S -C \
    '(- *)'{-h,--help}'[Show this help.]' \
    '(- *)'{-V,--version}'[Show the version number for this program.]' \
    '1: :_commands'\
    '2: :script-script'\
    '3:: :_files' \
    '*:: :->command_args'

  case "$state" in
    command_args) _command_args ;;
    script-script) __tt_complete script script  ;;
  esac
}

# shellcheck disable=SC2154
(( $+functions[_tt_completions] )) ||
function _tt_completions() {

  function _commands() {
    local -a commands
    # shellcheck disable=SC2034
    commands=(
      'bash:Generate shell completions for bash.'
      'fish:Generate shell completions for fish.'
      'zsh:Generate shell completions for zsh.'
    )
    _describe 'command' commands
  }

  function _command_args() {
    case "${words[1]}" in
      bash) _tt_completions_bash ;;
      fish) _tt_completions_fish ;;
      zsh) _tt_completions_zsh ;;
    esac
  }

  _arguments -w -s -S -C \
    '(- *)'{-h,--help}'[Show this help.]' \
    '1: :_commands' \
    '*:: :->command_args'

  case "$state" in
    command_args) _command_args ;;
  esac
}

# shellcheck disable=SC2154
(( $+functions[_tt_completions_bash] )) ||
function _tt_completions_bash() {

  _arguments -w -s -S -C \
    '(- *)'{-h,--help}'[Show this help.]'
}

# shellcheck disable=SC2154
(( $+functions[_tt_completions_fish] )) ||
function _tt_completions_fish() {

  _arguments -w -s -S -C \
    '(- *)'{-h,--help}'[Show this help.]'
}

# shellcheck disable=SC2154
(( $+functions[_tt_completions_zsh] )) ||
function _tt_completions_zsh() {

  _arguments -w -s -S -C \
    '(- *)'{-h,--help}'[Show this help.]'
}

# _tt "${@}"

compdef _tt tt
