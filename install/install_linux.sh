echo "Deleting the old files"
rm ~/.vimrc
rm ~/.zshrc
rm ~/.vim
rm ~/.gvimrc
rm ~/.gitconfig
rm ~/.gitignore
rm ~/.tmux.conf

echo "Symlinking files"
ln -s ../vim/.vimrc ~/.vimrc
ln -s ../vim/.vim ~/.vim
ln -s ../github/.gitconfig ~/.gitconfig

echo "All done."
