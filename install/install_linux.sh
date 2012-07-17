echo "Deleting the old files"
rm ~/.vimrc
rm -rf ~/.vim
rm ~/.gitconfig

echo "Symlinking files"
ln -s ~/dotfiles/vim/.vimrc ~/.vimrc
ln -s ~/dotfiles/vim/.vim ~/.vim
ln -s ~/dotfiles/github/.gitconfig ~/.gitconfig

echo "All done."
