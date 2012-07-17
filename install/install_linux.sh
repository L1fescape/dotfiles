echo "Deleting the old files"
rm ~/.vimrc
rm -rf ~/.vim
rm ~/.gitconfig

echo "Symlinking files"
ln -s ../vim/.vimrc ~/.vimrc
ln -s ../vim/.vim ~/.vim
ln -s ../github/.gitconfig ~/.gitconfig

echo "All done."
