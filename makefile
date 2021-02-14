all: .bashrc .curlrc .gitconfig .gitignore .profile .tmux.conf \
	.ssh/config .config/nvim .gnupg/gpg-agent.conf .alacritty.yml \
	.config/mpv/mpv.conf .emacs.d/init.el .emacs.d/config.org .emacs
SYMLINK=-ln --symbolic --no-target-directory ${PWD}/$< ~/$@
.% : %
	$(SYMLINK)
.ssh/config : ssh/config
	$(SYMLINK)
.config/nvim : nvim
	$(SYMLINK)
.gnupg/gpg-agent.conf : gnupg/gpg-agent.conf
	$(SYMLINK)
.config/mpv/mpv.conf : mpv.conf
	$(SYMLINK)
.emacs.d/init.el : emacs/init.el
	cp $< ~/$@
.emacs.d/config.org : emacs/config.org
	$(SYMLINK)
