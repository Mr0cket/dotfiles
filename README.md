# Macbook Pro dotfiles and setup

This repository contains everything to bootstrap my Macbook Pro (m1 ). This setup is explained in-depth in [dotfiles - Document and automate your Macbook setup](https://about.gitlab.com/blog/2020/04/17/dotfiles-document-and-automate-your-macbook-setup/).

In addition to the files stored in this repository, the following instructions are needed to fully setup a Macbook Pro.

## Preparations

### iterm2

Install it manually from the [website](https://www.iterm2.com/), start it and add it to the deck.

Initial settings:

- Create a new profile in `Preferences > Profile` named `white`
     - `Colors > Color presets > Tango Light`
     - `Session > Status bar enabled` and `Configure Status Bar`. Add `git state`, `CPU utilization`, `Memory utilization`. Click `Auto-Rainbow`.
- Mark `white` profile and select `Other Actions > Set as default`.

### Git (XCode)

Install it on the command line first, it will ask for permission.

```
xcode-select --install
```

### Sudo

Note: I keep this disabled for improved security, though some sessions may require heavy sudo usage.

```
sudo vim /private/etc/sudoers.d/milly

#milly  ALL=(ALL) NOPASSWD: ALL
```

### Backup

Copy the following files in your home directory:

* SSH Keys
* GPG Keys
* Custom settings for OhMyZSH

```
cd backup/
cp -r .ssh .gnupg .env .oh-my-zsh $HOME/
```

Sync most changes in your local dotfiles to repo:

```
./sync_remote.sh
```

> **Note**:
>
> The `dotenv` plugin is enabled in OhMyZSH which automatically
> reads the `.env` tokens from the user's home directory.

### Dot files

```
git clone https://gitlab.com/Mr0cket/dotfiles.git
cd dotfiles
```

Sync the files to local env

```
./bootstrap.sh
```

Apply macOS settings.

```
./.macos
```

Install Homebrew and OhMyZSH.

```
./brew_once.sh
```

Install tools and applications with Homebrew bundle.

```
brew bundle
```

This makes use of the [Brewfile](Brewfile) definitions.

## Essentials

### Tools

These tools are managed without Homebrew on purpose, e.g. for manual updates.

* Workflows: [Alfred](https://www.alfredapp.com/) including my Powerpack license
  * [HTTP Status Codes](https://github.com/ilstar/http_status_code)
  * [DNS: Dig](https://github.com/phallstrom/AlfredDig)
  * [Colors](https://github.com/zenorocha/alfred-workflows#colors-v202--download)
  * [Emoji](https://github.com/carlosgaldino/alfred-emoji-workflow)
  * [Encode/Decode](https://github.com/zenorocha/alfred-workflows#encodedecode-v180--download)
  * [Gmail](https://github.com/fniephaus/alfred-gmail)
  * [Gmail filters](https://github.com/inlet/alfred-workflow-gmail-filters)
  * [Sketch](https://madbitco.github.io/sketchflow/)
  * [Google Translate](https://github.com/xfslove/alfred-google-translate)
  * [Python Library](https://gitlab.com/deanishe/alfred-workflow)

### Virtualization and Containers

I only use Docker locally, required VMs run in Hetzner Cloud (private), GCP or AWS. Docker for Mac provides the `docker-compose` binary required to run demo environments. 

VirtualBox needs work with Kernel modules. I highly recommend to get a [Parallels license](https://www.parallels.com/de/products/desktop/buy/) instead. 

## Preferences

These are manual settings as they require user awareness.

### Keyboard

`Shortcuts`: Disable Spotlight in preparation for enabling Alfred next.

### Alfred

Start Alfred from the Applications folder, and change the hotkey to `Cmd+Space`.
Ensure that Spotlight is disabled in the system preferences.

### Finder

`Preferences > Sidebar` and add

- User home
- System root

## Additional Applications

* Google Chrome
* Docker (account required)
* JetBrains Toolbox (license required)
* NTFS for Mac (license required, I own a private license)
* Paw (license required, I own a private license)
* Spotify (account required)
* Telegram (account required)

### Handbook

Following the [GitLab handbook](https://about.gitlab.com/handbook/tools-and-tips/):

* [Loom](https://www.loom.com/)


### Homebrew

* Firefox (in order to reproduce UX bugs)
* VLC
* Wireshark

## Additional Hints

More insights can be found in these lists:

- [Setting examples](https://github.com/mathiasbynens/dotfiles/blob/master/.macos)
- [command overview](https://github.com/herrbischoff/awesome-macos-command-line).


## Upgrades

On major version upgrades, binaries might be incompatible or need a local rebuild. 
You can enforce a reinstall by running the two commands below, the second command
only reinstalls all application casks.

```
brew reinstall $(brew list)

brew reinstall $(brew list --cask)
```

When Xcode and compilers break, re-install the command line tools.

```
sudo rm -rf /Library/Developer/CommandLineTools
sudo xcode-select --install
```
