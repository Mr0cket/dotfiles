. "$HOME/.cargo/env"

export HOMEBREW_BUNDLE_FILE=$HOME/.dotfiles/Brewfile
export PATH=$PATH:/Users/milly/Library/Python/3.11/bin

# export ANDROID_HOME=$HOME/Library/Android/sdk
# export ANDROID_SDK=$HOME/Library/Android/sdk
if [ -n "${ANDROID_HOME}" ]; then
    export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/Contents/Home"
    export PATH=$PATH:$ANDROID_HOME/emulator
    export PATH=$PATH:$ANDROID_HOME/tools
    export PATH=$PATH:$ANDROID_HOME/tools/bin
    export PATH=$PATH:$ANDROID_HOME/platform-tools
fi

if [ -d "/usr/local/opt/tcl-tk/bin" ]; then
    export LDFLAGS="-L/usr/local/opt/tcl-tk/lib"
    export CPPFLAGS="-I/usr/local/opt/tcl-tk/include"
    export PATH=$PATH:/usr/local/opt/tcl-tk/bin
fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# local bins
export PATH=$PATH:$HOME/.bin

# apigeecli
export PATH=$PATH:$HOME/.apigeecli/bin

# Anthropic
export ANTHROPIC_API_KEY=$(cat ~/.anthropic_api_key)
