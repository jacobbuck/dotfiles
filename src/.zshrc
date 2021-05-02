#
# Options
#

# Changing Directories
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME

# Completion
setopt ALWAYS_TO_END
setopt AUTO_LIST
setopt AUTO_MENU
setopt NO_CASE_GLOB
setopt NO_LIST_BEEP

# Expansion and globbing
setopt EXTENDED_GLOB

# History
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY

# Input/Output
setopt CORRECT
setopt INTERACTIVE_COMMENTS
setopt NO_CLOBBER

# Job Control
setopt LONG_LIST_JOBS
setopt NO_BG_NICE
setopt NO_CHECK_JOBS
setopt NO_HUP

# Prompting
setopt PROMPT_SUBST

#
# Keybinding
#

bindkey -e

#
# Completion
#

zstyle :compinstall filename '$HOME/.zshrc'

zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

# Activate zsh-completions
FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

autoload -Uz compinit
compinit

#
# Prompt
#

prompt_gitstatus() {
  BRANCH=$(git branch --format="%(refname:short)" 2> /dev/null)
  if [ ! -z $BRANCH ]; then
    echo -n " %F{cyan}$BRANCH%f"
    if [ ! -z "$(git status --porcelain)" ]; then
      echo -n '%F{magenta}∙%f'
    fi
  fi
}

PROMPT='%F{blue}%(5~|%-1~/…/%3~|%4~)%f$(prompt_gitstatus) %F{white}›%f '

#
# Plugins
#

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

#
# Local overrides
#

[[ -s $HOME/.zshrc.local ]] && source $HOME/.zshrc.local
