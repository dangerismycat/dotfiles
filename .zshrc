# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
ZSH_THEME="powerlevel10k/powerlevel10k"
# DEFAULT_USER=rjames

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
COMPLETION_WAITING_DOTS="true"

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
plugins=(git zsh-autosuggestions zsh-nvm)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Git
alias files="git show --name-only"
alias whosebranch="git for-each-ref --format='%(color:cyan)%(authordate:format:%m/%d/%Y %I:%M %p)    %(align:25,left)%(color:yellow)%(authorname)%(end) %(color:reset)%(refname:strip=3)' --sort=authordate refs/remotes"
alias co="git checkout"
alias findname="git ls-files | grep"
alias newbranch="git checkout -b"
alias thatnewnew="git stash && git sync && git stash pop"
alias takemehome="git co master && git sync"
alias home="git co master && git upsync"
function findrange() { git log --all --after="$1 00:00" --before="$2 23:59" --stat --reverse --author="Jenkins" --invert-grep }
function db() {
  current_branch=$(git rev-parse --abbrev-ref HEAD);
  git checkout master;
  git br -D $current_branch;
}
# WHY DOESN'T THIS WORK?!
function gp() {
  branch=$(git rev-parse --abbrev-ref HEAD);
  git branch --set-upstream-to=origin/$branch $branch;
  git push origin $branch;
}

# npm
alias fuckit="rm -rf ./node_modules && yarn"
alias cleanitup="npm prune && npm i && npm start"

# Misc
alias aliass="code ~/.zshrc"
alias findfile="find . -name"
alias heyhey=". ~/.zshrc"
alias sourceit=". ~/.zshrc"
alias zshhist="code ~/.zsh_history"
alias howbig="stat -f%z"
alias howbigdir="du -h"
function newdir() { mkdir "$1" && cd "$_"; }

# iterate the line of a file and call input function
function maplines() {
  (( $# < 2 )) && { echo "Usage: maplines <File> <Callback>"; return; }
  local File=$1
  local Func=$2
  n=$(cat "$File" | wc -l)
  for (( i=1; i<=n; i++ )); do
    "$Func" "$(sed "${i}q;d" "$File")"
  done
}

# convert text to large bold emoji characters
bigger() {
    python /usr/local/bin/big.py "$*" | pbcopy
}

 export NVM_DIR="$HOME/.nvm"
  . "$(brew --prefix nvm)/nvm.sh"

export PATH=$PATH:$HOME/bin
# export EDITOR='code'

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme

# This seems to cause a bug? https://github.com/romkatv/powerlevel10k/issues/1628
# source /Users/rjames/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval $(thefuck --alias)
