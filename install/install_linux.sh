echo "Deleting the old files"
rm ~/.vimrc
rm ~/.zshrc
rm ~/.vim
rm ~/.gvimrc
rm ~/.gitconfig
rm ~/.gitignore
rm ~/.tmux.conf

echo "Symlinking files"
ln -s ~/prog/dotfiles/.vimrc ~/.vimrc
ln -s ~/prog/dotfiles/.zshrc ~/.zshrc
ln -s ~/prog/dotfiles/.vim ~/.vim
ln -s ~/prog/dotfiles/.gitconfig ~/.gitconfig

echo "All done."
