# Set working directory
cd $HOME/.dotfiles

# merge files that exist in dotfiles repo dir with latest versions
rsync \
  -avh \
  --existing \
  --stats \
  --no-implied-dirs \
  --no-perms \
  --ignore-errors \
  $HOME/ .

# update brew file with currently installed software
brew bundle dump --file Brewfile-local

# Merge locally dumped Brewfile with remote
# (this is a bit of a hack, but works)
sort -m Brewfile Brewfile-local | awk '/^\s*?$/||!seen[$0]++' >  Brewfile_tmp

# Replace remote with merged file and remove temp files
mv Brewfile_tmp Brewfile
rm Brewfile-local

git add .
git commit -m "Sync local dotfiles to remote";