if [ -d $"$HOME/.cargo" ]; then
	. "$HOME/.cargo/env"
fi

export HOMEBREW_BUNDLE_FILE=$HOME/.dotfiles/Brewfile
export PATH=$PATH:/Users/milly/Library/Python/3.11/bin

# Android development config
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

# asdf config
export ASDF_DATA_DIR="$HOME/.asdf"
export PATH="$ASDF_DATA_DIR/.shims:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# local bins
export PATH=$PATH:$HOME/bin

export PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"

# apigeecli
export PATH=$PATH:$HOME/.apigeecli/bin

# Secrets
if [ -d "$HOME/.secrets" ]; then
	source "$HOME/.secrets"
fi

export K9S_CONFIG_DIR="$HOME/.k9s"
