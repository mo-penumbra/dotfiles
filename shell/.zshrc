# Uncomment + run `zprof` in a new shell to profile startup time.
# zmodload zsh/zprof

# p10k instant prompt — keep near the top; interactive init must go above it.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

# Shell behavior
setopt AUTO_CD
setopt AUTO_PUSHD

# History
HISTSIZE=50000
SAVEHIST=$HISTSIZE
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias back='cd -'

function mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Files
alias ls='ls -G'
alias la='ls -laG'
alias ll='ls -lhG'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -i'
alias mkdir='mkdir -pv'

# Git
alias gs='git status'
alias ga='git add'
alias gc='git commit -v'
alias gp='git push'
alias gpl='git pull'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'

function gcb() {
  git checkout -b "$1" && git push -u origin "$1"
}

# Misc
alias grep='grep --color=auto'
alias c='clear'
alias h='history'

export UV_NO_SYNC=1

function cheat() {
  echo "NAVIGATION"
  echo "  ..  ...  ....     cd up directories"
  echo "  back              cd to previous dir (cd -)"
  echo "  mkcd <dir>        mkdir and cd into it"
  echo ""
  echo "GIT"
  echo "  gs=status  ga=add  gc=commit  gp=push  gpl=pull  gd=diff"
  echo "  gb=branch  gco=checkout  gcb <name>=create branch + push"
  echo ""
  echo "FILES"
  echo "  ls  la  ll        list files (la=all, ll=long)"
  echo "  cp  mv  rm        safe ops with confirmation"
  echo ""
  echo "HISTORY"
  echo "  h                 show history"
  echo "  !!                repeat last command"
  echo "  sudo !!           run last command with sudo"
  echo "  !\$                last argument of previous command"
  echo "  !^                first argument of previous command"
  echo "  !*                all arguments of previous command"
  echo "  !n                run command number n from history"
  echo "  !string           run last command starting with string"
  echo "  ^old^new          replace old with new in last command"
  echo "  ctrl+r            search history backwards"
  echo ""
  echo "LINE EDITING"
  echo "  ctrl+a / ctrl+e   jump to start / end of line"
  echo "  ctrl+w            delete word backwards"
  echo "  ctrl+u            delete to start of line"
  echo "  ctrl+k            delete to end of line"
  echo "  alt+b / alt+f     move word back / forward"
  echo ""
  echo "MISC"
  echo "  c=clear  ctrl+l   clear screen"
  echo "  ctrl+z / fg       suspend / resume job"
  echo "  cmd1 && cmd2      run cmd2 if cmd1 succeeds"
  echo "  cmd1 || cmd2      run cmd2 if cmd1 fails"
  echo ""
  echo "DEPLOYMENT (laptop)"
  echo "  pig list vms                             list available VMs"
  echo "  pig ssh <vm>                             ssh in + attach remote tmux"
  echo "  pig deploy <vm>                          deploy ms to staging kernel"
  echo "  pig deploy <vm> --kernel datascience     deploy ms to production kernel"
  echo ""
  echo "TMUX (prefix = Ctrl-a)   [laptop]"
  echo "  tm                      attach to (or create) 'main' session"
  echo "  vm <name>               open/jump to a window running pig ssh dev-<name>-host"
  echo "  prefix d                detach (leave session running)"
  echo "  prefix r                reload tmux config"
  echo ""
  echo "  panes"
  echo "    prefix | / prefix -   split vertical / horizontal (keeps cwd)"
  echo "    alt + arrows          move between panes (no prefix)"
  echo "    prefix x              kill current pane"
  echo "    prefix z              zoom pane toggle"
  echo ""
  echo "  windows"
  echo "    prefix c              new window (keeps cwd)"
  echo "    prefix 1..9           jump to window by number"
  echo "    prefix n / prefix p   next / previous window"
  echo "    prefix w              window picker"
  echo "    prefix ,              rename window"
  echo "    prefix &              kill window"
  echo ""
  echo "  sessions"
  echo "    prefix s              session picker"
  echo "    prefix \$              rename session"
  echo ""
  echo "  copy mode (vi)"
  echo "    prefix [              enter copy mode; q to exit"
  echo "    v                     begin selection"
  echo "    y                     copy selection and exit"
  echo "    prefix ]              paste"
  echo ""
  echo "  pass Ctrl-a to the shell: press Ctrl-a twice"
}

# Prompt
[ -f ~/powerlevel10k/powerlevel10k.zsh-theme ] && source ~/powerlevel10k/powerlevel10k.zsh-theme
[ -f ~/.p10k.zsh ] && source ~/.p10k.zsh

# Completions
fpath+=~/.zfunc; autoload -Uz compinit; compinit

# OS-specific config (Darwin/Linux)
case "$(uname)" in
  Darwin) [ -f ~/.zshrc-mac ]   && source ~/.zshrc-mac   ;;
  Linux)  [ -f ~/.zshrc-linux ] && source ~/.zshrc-linux ;;
esac
