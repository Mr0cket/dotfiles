# merge files that exist in dotfiles repo with updated local versions
rsync -avh --existing --stats ~ .

git add .

git commit -m "Sync local configs to remote";