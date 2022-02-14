# merge files that exist in dotfiles repo dir with latest versions
rsync \
  -avh \
  --existing \
  --stats \
  --no-implied-dirs \
  $HOME/ .

# update brew file with currently installed software
brew bundle dump --file $HOME/.dotfiles/Brewfile-local

# Merge locally dumped Brewfile with remote
sort -m $HOME/.dotfiles/Brewfile $HOME/.dotfiles/Brewfile-local | awk '/^\s*?$/||!seen[$0]++' > Brewfile

# Delete local Brewfile
rm $HOME/.dotfiles/Brewfile-local

git add .
git commit -m "Sync local configs to remote";