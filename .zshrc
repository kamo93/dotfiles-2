# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/kamo93/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="spaceship"

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
plugins=(git node vi-mode tmux zsh-syntax-highlighting)

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
#

# path for pip3 installationa
#export PATH=/home/kamo93/.local/bin:$PATH
#
# export z script https://github.com/rupa/z
. ~/.config/z/z.sh
# fnm #robo3t
export PATH=/usr/local/bin/robo3t:$PATH
export PATH=/home/kamo93/.fnm:$PATH
export PATH=/home/kamo93/lua-language-server/bin/:$PATH
export EDITOR='nvim'
eval "`fnm env --use-on-cd`"
alias nzsh="nvim ~/.zshrc"
alias robo3t="robo3t &"
alias vconf='cd ~/.config/nvim && nvim init.lua'
alias sozsh="source ~/.zshrc"
alias open-freeze="(cd ~/Downloads/OpenFreezeCenter/ ; sh at_startup.sh)"

# set vi mode mark enable
eval spaceship_vi_mode_enable
alias ohmyzsh="nvim ~/.oh-my-zsh"

export TERM=xterm-256color

# fzf settings
export FZF_DEFAULT_COMMAND='gp --type f --hidden --follow --exclude .git'	
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

fzf-git-branch(){
	git rev-parse HEAD > /dev/null 2>&1 || return
	
	git branch --color=always --all --sort=committerdate |
		grep -v HEAD |
		fzf --height 70% --ansi --no-multi --preview-window right:50% --bind "ctrl-p:toggle-preview,ctrl-w:toggle-preview-wrap" \
			--preview 'git log -n 50 --color=always --date=relative --pretty="format:%C(yellow)%h %Cblue%>(12)%ad %Cgreen%<(7)%aN%Cred%d %Creset%s" $(sed "s/.* //" <<<{})' | sed "s/.* //"
}

fzf-git-checkout() {
	git rev-parse HEAD > /dev/null 2>&1 || return
	local branch
	branch=$(fzf-git-branch)
	if [[ "$branch" = "" ]]; then
		echo "no branches selected"
		return
	fi
	
	if [[ "$branch" = 'remotes/'* ]]; then
		git checkout --track $branch
	else
		git checkout $branch
	fi
}

alias fgb='fzf-git-branch'
alias fgco='fzf-git-checkout'

source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias luamake=/home/kamo93/lua-language-server/3rd/luamake/luamake
