#
# ~/.bash_profile
#

# -- Environment variables -- #
export VISUAL=nvim
export EDITOR=nvim
export SUDO_EDITOR=nvim
export PATH=~/bin:~/.local/bin:$PATH
export AUR_PAGER=ranger

# -- GNOME keyring -- #
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

[[ -f ~/.bashrc ]] && . ~/.bashrc &> /dev/null

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ]; then
    if [ "$XDG_VTNR" -eq 1 ]; then
        exec startx
    elif [ "$XDG_VTNR" -eq 2 ]; then
        exec nvidia-xrun
    fi
fi
