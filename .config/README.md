Following: https://www.atlassian.com/git/tutorials/dotfiles

Need this alias

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

or use below to add to .bashrc

echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
