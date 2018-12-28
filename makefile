all: .bashrc .curlrc .gitconfig .gitignore .profile .screenrc .vimrc
SYMLINK=-ln --symbolic `readlink --canonicalize $<` ~/$@
.% : %
	$(SYMLINK)
.vim/ftplugin : vim/ftplugin
	$(SYMLINK)
