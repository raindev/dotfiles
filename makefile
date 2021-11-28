all: .bashrc .bash_functions .curlrc .gitconfig .gitignore .profile .tmux.conf \
	.ssh/config .config/nvim .alacritty.yml .config/mpv/ .emacs.d/ \
	.config/mpv/mpv.conf .emacs.d/init.el .emacs.d/config.org .emacs
SYMLINK=-ln --symbolic --force --no-target-directory ${PWD}/$< ~/$@
MKDIR=mkdir --parents ~/$@
.% : %
	$(SYMLINK)
.ssh/config : ssh/config
	chmod 600 $<
	cp --archive $< ~/$@
.config/nvim : nvim
	$(SYMLINK)
.config/mpv/mpv.conf : mpv.conf
	$(SYMLINK)
.emacs.d/init.el : emacs/init.el
	cp $< ~/$@
.emacs.d/config.org : emacs/config.org
	$(SYMLINK)
.config/mpv/ :
	$(MKDIR)
.emacs.d/ :
	$(MKDIR)
