#
# ~/.bash_profile
#

# -- Environment variables -- #
export VISUAL=nvim
export EDITOR=nvim
export SUDO_EDITOR=nvim
export PATH=~/bin:~/.local/bin:$PATH

[[ -f ~/.bashrc ]] && . ~/.bashrc &> /dev/null
