# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""


alias test_ms="uv run python -m pytest packages/ms_python/tests/"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

setopt AUTO_CD
setopt AUTO_PUSHD
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias back='cd -'

function mkcd() {
  mkdir -p "$1" && cd "$1"
}

alias ls='ls -G'
alias la='ls -laG'
alias ll='ls -lhG'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -i'
alias mkdir='mkdir -pv'

alias gs='git status'
alias ga='git add'
alias gc='git commit -v'
alias gp='git push'
alias gpl='git pull'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias test_ms="cd ~/penumbra && uv run python -m pytest packages/ms_python/tests/"

function gcb() {
  git checkout -b "$1" && git push -u origin "$1"
}

export UV_NO_SYNC=1

alias etl="uv run --project ~/penumbra etl"
alias pig="uv run --project ~/penumbra pig"
alias cronctl="uv run --project ~/penumbra cronctl"

alias grep='grep --color=auto'
alias c='clear'
alias h='history'

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
  echo "  !$                last argument of previous command"
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
  echo "DEPLOYMENT"
  echo "  pig targets                              list available VMs"
  echo "  pig deploy <vm>                          deploy ms to staging kernel"
  echo "  pig deploy <vm> --kernel datascience     deploy ms to production kernel"
  echo "  pig deploy resource_intensive_vm         deploy to resource_intensive_vm"
  echo "  pig deploy macro_vm                      deploy to macro_vm"
}

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

fpath+=~/.zfunc; autoload -Uz compinit; compinit

# Added by Antigravity
export PATH="/Users/mo/.antigravity/antigravity/bin:$PATH"
