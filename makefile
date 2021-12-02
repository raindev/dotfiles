all: .bashrc .bash_functions .curlrc .gitconfig .gitignore .profile .tmux.conf \
	.ssh/config .config/nvim .alacritty.yml .config/mpv/ \
	.config/mpv/mpv.conf
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
.config/mpv/ :
	$(MKDIR)
.emacs.d/ :
	$(MKDIR)
