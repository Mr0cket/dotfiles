# ZSH alias
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="cd ~/.oh-my-zsh/custom"
alias ohmyalias="vim ~/.oh-my-zsh/custom/aliases.zsh"

# Delete all remote tracking Git branches where the upstream branch has been deleted
alias git_prune="git fetch --prune && git branch -vv | grep 'origin/.*: gone]' | awk '{print \$1}' | xargs git branch -d"

# Generate a secure password and copy it to clipboard
alias genpw='LC_ALL=C tr -dc "[:alnum:]" < /dev/urandom | head -c 20 | pbcopy'

# Check external ip address
alias myip='curl ifconfig.co/'

# Emulate intel based arch
alias podi='arch -arch x86_64 pod install'
alias intel='arch -arch x86_64'

# copy working directory
alias cwd='pwd | pbcopy'

# restart adb server
alias adbrs='adb kill-server && adb start-server'

# Start Fastlane
alias fastlane='bundle exec fastlane'

# Start Google Chrome
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

# open brthrs projects
alias bp='cd ~/brthrs/projects && ls'

# download a subdir from gh (e.g check out an example project)
alias git_clone_sub='() { ;}'

# Open android studio (project) from commandline
alias AndroidStudio="open -a /Applications/Android\ Studio.app"

# Python 3 aliases
alias python=python3
alias pip=pip3

#Kubernets
alias k=kubectl
complete -o default -F __start_kubectl k

# Terraform aliases
alias tf=terraform
alias tfi='terraform init'
alias tfp='terraform plan'

# Format & read piped json output
alias jql="jq -C | less -R"

# Switch gh users
alias sw_git='() { var1=$HOME/.ssh/id_$1_ed25519; if [ ! -f $var1 ]; then echo "key file $var1 doesnt exist"; else echo "[git] switching default ssh command to use key: $var1"; export GIT_SSH_COMMAND="ssh -i $var1 -o IdentitiesOnly=yes"; sw_gh $1; fi;}'
alias sw_gh='() { var1=$HOME/.gh-$1; if [ ! -d $var1 ]; then echo "$var1 doesnt exist"; else echo "[gh] switching to gh profile $var1"; export GH_CONFIG_DIR=$var1; fi;}'

## Gcloud aliases

#GCP ALIAS
alias gc="gcloud"
alias sa_auth="gcloud auth activate-service-account $GCP_SA --key-file=$GCP_SA_KEY --project=$GCP_SA_PJ"
alias gc-conf-ls="gcloud config configurations list"
alias gc-conf-info="gcloud config list"
alias gc-conf-set="gcloud config configurations activate"
alias gc-conf-new="gcloud config configurations create"
alias gc-ssh="gcloud compute ssh $GCP_INSTANCE"
alias gc-port-forward="gcloud compute ssh $GCP_INSTANCE -- -NL"
alias gc-auth="gcloud auth login && gcloud auth application-default login"
alias gc-gke-set="gcloud container clusters get-credentials"
alias gpat='gcloud auth print-access-token' # prints access token
alias gcurl='curl -H "Authorization: Bearer $(gpat)"'
alias gcurl_test='echo "-H Authorization: GoogleLogin auth=$(gpat)"'
alias gcbilling='gcloud beta billing accounts list'


alias brewgit='/opt/homebrew/bin/git'

alias fingerprint='ssh-keygen -lf'
