# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$USER.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$USER.zsh"
fi

# Source .zshprofile if it exists
if [ -f ~/.zshprofile ]; then
	source ~/.zshprofile
fi

# Source helm config
if [ -f "$HOME/.helm_zsh" ]; then
	source "$HOME/.helm_zsh"
fi

# ASDF
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

## GOlang config
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# TheFuck
eval $(thefuck --alias)

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="random"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
ZSH_THEME_RANDOM_CANDIDATES=("robbyrussell" "agnoster")

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

ZSH_CUSTOM="${ZSH}/custom"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git aws asdf gcloud)

source $ZSH/oh-my-zsh.sh
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# **User configuration**

# Default GH configuration directory (commented since settings should be configured through git)
# export GH_CONFIG_DIR=$HOME/.gh-devoteam
export GIT_SSH_COMMAND="ssh -o IdentitiesOnly=yes"

# Add ssh cert identities to ssh agent. Ignore public identity (.pub) files
eval "$(ssh-agent -s >/dev/null 2>&1)"
for identity in $(ls -1 $HOME/.ssh/id_* | grep -v '\.pub$'); do
	/usr/bin/ssh-add --apple-load-keychain $identity >/dev/null 2>&1
done

# Locale environment stuff
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR='micro'
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
else
	export VISUAL="code --wait"
fi

## Gcloud/provider config
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# All aliases should be set in "~/.oh-my-zsh/custom/aliases.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Adds autocomplete to ZSH shell
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /Users/milosilva/.asdf/shims/terraform terraform
complete -o nospace -C /Users/milosilva/.asdf/shims/terraform tf

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Docker default
export DOCKER_DEFAULT_PLATFORM=linux/arm64

# Disable fork safety
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# Buildpack completion
[[ $commands[pack] ]] && . $(pack completion --shell zsh) # The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/milo.silva/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/milo.silva/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/milo.silva/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/milo.silva/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/milo.silva/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/milo.silva/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
