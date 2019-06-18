all: .bashrc .curlrc .gitconfig .gitignore .profile .screenrc .vimrc \
	.vim/ftplugin .ssh/config .config/nvim .gnupg/gpg-agent.conf
SYMLINK=-ln --symbolic --no-target-directory ${PWD}/$< ~/$@
.% : %
	$(SYMLINK)
.vim/ftplugin : vim/ftplugin
	$(SYMLINK)
.ssh/config : ssh/config
	$(SYMLINK)
.config/nvim : nvim
	$(SYMLINK)
.gnupg/gpg-agent.conf : gnupg/gpg-agent.conf
	$(SYMLINK)
