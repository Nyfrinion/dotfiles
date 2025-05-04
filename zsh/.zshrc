# Path setup
export PATH="$HOME/bin:/usr/local/bin:$PATH"

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt share_history

# Prompt
autoload -Uz promptinit; promptinit
prompt pure  # Or use another like `prompt adam1`, `prompt walters`

# Aliases
alias ll='ls -lah'
alias gs='git status'
alias ga='git add .'
alias ..='cd ..'
alias ...='cd ../..'

# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Completion
autoload -Uz compinit
compinit

# Enable correction
setopt correct

# Enable globbing and expansion behavior
setopt extended_glob
setopt no_nomatch

# Disable flow control (Ctrl+S freeze)
stty -ixon

# Autoload key bindings
bindkey -e

# Load NVM (if used)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

# FZF (if installed)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
