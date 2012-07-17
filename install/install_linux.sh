echo "Deleting the old files"
rm ~/.vimrc
rm -rf ~/.vim
rm ~/.gitconfig

echo "Symlinking files"
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.vim ~/.vim
ln -s ~/dotfiles/github/.gitconfig ~/.gitconfig

echo "All done."
