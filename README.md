raindev's .[dot]files
=====================

Install
-------

Install [brew](http://brew.sh) (do not believe you're not using it yet):

    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

Install [rcm](https://github.com/thoughtbot/rcm):

    brew tap thoughtbot/formulae
    brew install rcm

Clone onto your machine:

    git clone https://github.com/raindev/dotfiles.git

Install:

    rcup -d dotfiles -x README.md -x Brewfile -x launchd.conf
