# Delete all remote tracking Git branches where the upstream branch has been deleted
alias git_prune="git fetch --prune && git branch -vv | grep 'origin/.*: gone]' | awk '{print \$1}' | xargs git branch -d"

# Generate a secure password and copy it to clipboard
alias genpw='LC_ALL=C tr -dc "[:alnum:]" < /dev/urandom | head -c 20 | pbcopy'

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
