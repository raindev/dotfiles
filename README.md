raindev's .[dot]files
=====================

Install
-------

Install [brew](http://brew.sh) (do not believe you're not using it yet):

    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

Install [rcm](https://github.com/thoughtbot/rcm):

    brew tap thoughtbot/formulae
    brew install rcm

Clone the repo onto your machine:

    git clone https://github.com/raindev/dotfiles.git

Hide the dotfiles directory:

    mv dotfiles .dotfiles

Install:

    rcup -d .dotfiles -x README.md -x Brewfile -x launchd.conf
