# ANSI Colors
export CLICOLOR=1

# Default applications/binaries
export BROWSER="Firefox"
export EDITOR="micro"
export PAGER="less"
export VISUAL="micro"

# History
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000

# Local overrides
[[ -s $HOME/.zshenv.local ]] && source $HOME/.zshenv.local
