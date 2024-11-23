#!/bin/zsh

cd ${0:a:h}

git pull origin main

function sync() {
	rsync --exclude ".git/" \
		--exclude "doc/" \
		--exclude ".DS_Store" \
		--exclude ".macos" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE" \
		--exclude "update_repo.sh" \
		--exclude "sync_remote.sh" \
		--exclude "Brewfile" \
		--exclude "brew_once.sh" \
		-avh --no-perms . ~;
}

sync

# install custom software
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

unset sync;
