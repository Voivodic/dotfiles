# Set neovim as the default editor
export EDITOR="nvim"

# Set some aliases
alias ls="ls --color=auto"
alias ll="ls -lh --color=auto"
alias la="ls -lha --color=auto"

# Check if the script is running inside a tmux session
if [ -z "$TMUX" ]; then
    # Start a new tmux session and run nushell
    tmux new-session -s main 'nu; exit; exit'
else
    # Just run nushell
    nu; exit
fi

