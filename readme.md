Dotfiles & More
===============

Install
-------

    sh -c "$(curl -fsLS get.chezmoi.io)" -- init raindev \
	&& chezmoi apply ~/.config/chezmoi \
	&& chezmoi apply

See [chezmoi](https://www.chezmoi.io/).
