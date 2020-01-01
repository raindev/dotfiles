all: .bashrc .curlrc .gitconfig .gitignore .profile .tmux.conf \
	.ssh/config .config/nvim .gnupg/gpg-agent.conf .alacritty.yml \
	.config/mpv/mpv.conf
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
