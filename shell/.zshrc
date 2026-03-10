# Disable p10k terminal color detection (fixes tmux OSC leakage)
typeset -g POWERLEVEL9K_TERM_SHELL_INTEGRATION=false

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Speed up large directories - skip checking untracked files for git status
DISABLE_UNTRACKED_FILES_DIRTY="true"

source $ZSH/oh-my-zsh.sh

setopt AUTO_CD AUTO_PUSHD SHARE_HISTORY APPEND_HISTORY INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE

# Edit command line in $EDITOR with Ctrl+X, E
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey -s '^Xgc' 'gcmsg ""\C-b'

alias ..='cd ..' ...='cd ../..' ....='cd ../../..' back='cd -'
function mkcd() { mkdir -p "$1" && cd "$1" }
alias ls='ls --color=auto' la='ls -la' ll='ls -lh'
alias cp='cp -iv' mv='mv -iv' rm='rm -i' mkdir='mkdir -pv'
alias gs='git status' ga='git add' gc='git commit -v' gp='git push' gpl='git pull' gd='git diff'
alias grep='grep --color=auto' c='clear' h='history'
alias rez='source ~/.zshrc'
alias fixpy='uvx ruff --fix'
alias gpom='git pull origin main'
alias gpn='git pushnew'
alias gcup='git cleanup'

# uv shortcuts
alias uvs='uv sync'
alias uvl='uv lock'

# TODO: Customize branch prefix - Create branch with your prefix: myb feature-name -> git checkout -b <initials>/feature-name
# function myb() { git checkout -b "<YOUR_INITIALS>/$1" }

# Fast mode for large directories - disables autosuggestions
fast() {
    unset ZSH_AUTOSUGGEST_STRATEGY
    ZSH_AUTOSUGGEST_MANUAL_REBIND=1
    _zsh_autosuggest_disable
    echo "Fast mode enabled"
}

slow() {
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    _zsh_autosuggest_enable
    echo "Normal mode restored"
}

alias claude='TMPDIR=~/tmp CLAUDE_DEBUG=1 ~/.local/bin/claude'

source ~/powerlevel10k/powerlevel10k.zsh-theme

# Hide username@hostname segment
POWERLEVEL9K_CONTEXT_DEFAULT_CONTENT_EXPANSION=''

. "$HOME/.local/bin/env"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Auto-activate .venv if present in current directory or parent
function auto_activate_venv() {
    local dir="$PWD"
    while [[ "$dir" != "/" ]]; do
        if [[ -f "$dir/.venv/bin/activate" ]]; then
            source "$dir/.venv/bin/activate"
            return
        fi
        dir=$(dirname "$dir")
    done
}

auto_activate_venv

export EDITOR=vim
export VISUAL=vim
export JUPYTER_PATH="/opt/jupyter/kernels:/usr/share/jupyter/kernels"

export GPG_TTY=$(tty)

# MCP Authentication Tunnel Helper

# Simple version using your SSH config
mcp-tunnel() {
    local port="${1:?Usage: mcp-tunnel <port> [host]}"
    local host="${2:-resourceintensive}"

    # Strip any hidden characters (carriage returns, whitespace)
    port=$(echo "$port" | tr -cd '0-9')

    if [[ -z "$port" ]]; then
        echo "Error: Invalid port number"
        return 1
    fi

    echo "Starting tunnel: localhost:$port -> $host:$port"
    echo "Press Ctrl+C to close the tunnel"
    ssh -L "${port}:localhost:${port}" -N "$host"
}

# Azure VM version
mcp-tunnel-az() {
    local port="${1:?Usage: mcp-tunnel-az <port>}"
    local rg="${2:-dev-rg}"
    local vm="${3:-dev-resourceintensive-host}"

    echo "Starting Azure tunnel: localhost:$port -> $vm:$port"
    echo "Press Ctrl+C to close the tunnel"
    az ssh vm --resource-group "$rg" --name "$vm" -- -L "$port:localhost:$port" -N
}

# Bonus: Parse port from URL if you copy the whole auth URL
mcp-tunnel-url() {
    local url="${1:?Usage: mcp-tunnel-url <auth-url> [host]}"
    local host="${2:-resourceintensive}"
    local port

    # Extract port from URL like http://localhost:64776/...
    port=$(echo "$url" | grep -oE 'localhost:([0-9]+)' | cut -d: -f2 | tr -cd '0-9')

    if [[ -z "$port" ]]; then
        echo "Error: Could not extract port from URL"
        return 1
    fi

    echo "Extracted port: $port"
    mcp-tunnel "$port" "$host"
}

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:/opt/rust/bin:$PATH"

# Claude Code with in-process teammate mode
alias cc="claude --teammate-mode in-process"
