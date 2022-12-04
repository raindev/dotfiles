all: .bashrc .bash_functions .curlrc .gitconfig .gitignore .profile .tmux.conf \
	.ssh/config .config/nvim .wezterm.lua  .config/mpv/ \
	.config/mpv/mpv.conf .git/config .config/autostart
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
.config/autostart : autostart
	$(SYMLINK)
.PHONY : .git/config
.git/config :
	git config filter.nvim-background.clean "sed \"s/background = 'dark'/background = 'light'/\""
