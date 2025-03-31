#!/bin/bash

# Set some aliases
alias ls="ls --color=auto"
alias ll="ls -lh --color=auto"
alias la="ls -lha --color=auto"

# Check if the script is running inside a nix shell
# if [ -z "$NIX_GCROOT" ]; then
#     # Check if the script is running inside a tmux session
#     if [ -z "$TMUX" ]; then
#         # Start a new tmux session and run nushell
#         tmux new-session -s main 'nu; exit; exit'; exit
#     else
#         # Just run nushell
#         nu; exit
#     fi
# fi

# Set neovim as the default editor
export EDITOR="nvim"
