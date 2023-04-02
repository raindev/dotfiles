all: .bashrc .profile .tmux.conf \
	.ssh/config .config/mpv/ \
	.config/mpv/mpv.conf .config/autostart
SYMLINK=-ln --symbolic --force --no-target-directory ${PWD}/$< ~/$@
MKDIR=mkdir --parents ~/$@
.% : %
	$(SYMLINK)
.ssh/config : ssh/config
	chmod 600 $<
	cp --archive $< ~/$@
.config/mpv/mpv.conf : mpv.conf
	$(SYMLINK)
.config/mpv/ :
	$(MKDIR)
.config/autostart : autostart
	$(SYMLINK)
.PHONY : .git/config
.git/config :
	git config filter.nvim-background.clean "sed \"s/background = 'dark'/background = 'light'/\""
