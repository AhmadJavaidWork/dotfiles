HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

alias ni="npm install"
alias nrd="npm run dev"
alias nrb="npm run build"

alias pi="pnpm install"
alias prd="pnpm run dev"
alias prb="pnpm run build"

alias c="code"

alias vim="nvim"

export PATH="$PATH:/home/rv/IntelliJ/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:/usr/local/zig-x86_64-linux-0.16.0"
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$PATH:/home/rv/go/bin"
export PATH="$PATH:/usr/local/tree-sitter"
