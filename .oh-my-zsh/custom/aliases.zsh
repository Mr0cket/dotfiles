# ZSH alias
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="cd ~/.oh-my-zsh/custom"
alias ohmyalias="vim ~/.oh-my-zsh/custom/aliases.zsh"
alias mcd='() { mkdir -p -- "$1" && cd -P -- "$1"}'
alias watch2='watch -n 2 '
alias v='vim'
alias file_size='wc -c'
alias dir_size='du -hs'
alias jcurl='curl -H "Content-type: application/json"'
alias base64d='echo "$1" | base64 -d'

# SHA private key fingerprint
alias fingerprint='ssh-keygen -lf'

# git/github aliases
alias gclone='git clone'

## Delete all remote tracking Git branches where the upstream branch has been deleted
alias git_prune="git fetch --prune && git branch -vv | grep 'origin/.*: gone]' | awk '{print \$1}' | xargs git branch -d"

## "Oops, I made a typo"
alias gcap="git commit --amend --no-edit && git push -f"
alias ghpr='gh pr create -B main -t $(git branch --show-current)'

alias gcom='git commit -m'

# Generate a secure password and copy it to clipboard
alias genpw='LC_ALL=C tr -dc "[:alnum:]" < /dev/urandom | head -c 20 | pbcopy'

# Check external ip address
alias myip='curl ifconfig.co/'

# Emulate intel based arch
alias podi='arch -arch x86_64 pod install'
alias intel='arch -arch x86_64'

# EOF command
alias eof='cat <<EOF >'
alias EOF='cat <<EOF >'

# copy working directory
alias cwd='pwd | pbcopy'

# restart adb server
alias adbrs='adb kill-server && adb start-server'

# Start Fastlane
alias fastlane='bundle exec fastlane'

# Start Google Chrome
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

# download a subdir from gh (e.g check out an example project)
alias git_clone_sub='() { ;}'

# Open android studio (project) from commandline
alias AndroidStudio="open -a /Applications/Android\ Studio.app"

# Python 3 aliase
alias pip=pip3
alias py=python3
alias venv='py -m venv'

# docker
alias docker-tags=''

# Kubernetes
alias k=kubectl
alias kd='kubectl describe'
alias kg='kubectl get'
alias ke='kubectl explain'

### Get
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgn='kubectl get nodes'
alias kgi='kubectl get ingress'
alias kgd='kubectl get deployment'

### describe
alias kdp='kubectl describe pods'
alias kds='kubectl describe services'
alias kdn='kubectl describe nodes'
alias kdi='kubectl describe ingress'
alias kdd='kubectl describe deployment'

### Argocd
alias a=argocd

### Helm
alias h='helm'

## Switch current cluster context
alias kctx='kubectx'
alias kgc='kubectl config get-clusters'
alias ksproxy='kubectl config set clusters.$(kubectx -c).proxy-url http://localhost:8888'

### https://github.com/nicolaka/netshoot
alias kssh='echo "starting netshoot pod in $(kubectx -c) cluster..." && kubectl run netshoot --rm -i --tty --image nicolaka/netshoot -- zsh'
alias kdbg='kubectl debug $1 -it --image=nicolaka/netshoot'

complete -o default -F __start_kubectl k

# Terraform aliases
alias tf=terraform
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'

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
alias gpat='gcloud auth print-access-token'   # prints access token
alias gpit='gcloud auth print-identity-token' # Prints identity token
alias gcbilling='gcloud beta billing accounts list'

alias gcurl='curl -H "Authorization: Bearer $(gpat)"'

alias gicurl='curl -H "Authorization: Bearer $(gpit)"'
alias jigcurl='curl -H "Authorization: Bearer $(gpit)" -H "Content-type: application/json"'

alias gc-bastion='() {
  if [[ -z "$1" || -z "$2" ]]; then
    echo "provide vm name and project e.g: gc-bastion {VM_NAME} {PROJECT}";
  else
    gcloud compute ssh $1 --tunnel-through-iap --project=$2 -- -4NL 8888:localhost:8888;
  fi
}'

alias gke-credentials='() {if [ -z "$1" ]; then echo "provide env name e.g: gke-credentials staging"; else gcloud container get-credentials "cluster-be-$1 --internal-ip --region=europe-west1 --project="pj-platform-$1 }'

alias cvlc='vlc -Idummy'

alias conn='() { until ping -c1 $1  >/dev/null 2>&1; do ; done; cvlc --play-and-exit ~/playground/tts/hack_the_planet.mp3}'

alias brewgit='/opt/homebrew/bin/git'

# Docker aliases
alias swagger='() {
    option=""
    if [[ -n "$1" ]]; then
        echo "Loading document $1"
        option="-e SWAGGER_FILE=$1"
    fi
    docker run --rm -p 666:8080 $option swaggerapi/swagger-editor:next-v5-unprivileged
}'

#alias mp42gif='() {
#  if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
#    echo "command uses 3 inputs: mp42gif input.mp4 output.gif caption_text"
#  else
#    ffmpeg -i "$1" -vf "fps=10,scale=320:-1:flags=lanczos,drawtext=text='$3':fontcolor=white:borderw=2:bordercolor=black:fontsize=24:x=(w-text_w)/2:y=(h-text_h)-10" -c:v pam -f image2pipe - | convert -delay 10 - -loop 0 -layers optimize "$2"
#  fi
#}'
