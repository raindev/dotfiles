all: .bashrc .curlrc .gitconfig .gitignore .profile .screenrc \
	.ssh/config .config/nvim/init.vim .gnupg/gpg-agent.conf
SYMLINK=-ln --symbolic --no-target-directory ${PWD}/$< ~/$@
.% : %
	$(SYMLINK)
.ssh/config : ssh/config
	$(SYMLINK)
.config/nvim/init.vim : nvim/init.vim
	mkdir ~/$(@D)
	$(SYMLINK)
.gnupg/gpg-agent.conf : gnupg/gpg-agent.conf
	$(SYMLINK)
