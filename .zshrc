#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

if [[ $TMUX != "" ]]; then
  # Snag current tmux window title if any
  WINDOW_TITLE=$(tmux list-window -F "#{window_name}#{window_active}" | sed '/0$/d' | sed 's/.$//')
  if [[ $WINDOW_TITLE == 'reattach-to-user-namespace' ]]; then
    WINDOW_TITLE=$(pwd)
  fi
fi

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

zstyle ':prezto:module:terminal' auto-title 'no'

# Git fastness
__git_files () {
  _wanted files expl 'local files' _files
}

alias tr="tmux rename-window"
export WORDCHARS=${WORDCHARS//[&.;\/]}

if [[ $TMUX != "" && $WINDOW_TITLE != "" ]]; then
  tr $WINDOW_TITLE
fi
