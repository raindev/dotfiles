all: .bashrc .curlrc .gitconfig .gitignore .profile .screenrc .vimrc \
	.vim/ftplugin
SYMLINK=-ln -s ${PWD}/$< ~/$@
.% : %
	$(SYMLINK)
.vim/ftplugin : vim/ftplugin
	$(SYMLINK)
