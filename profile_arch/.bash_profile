#
# ~/.bash_profile
#

# -- Environment variables -- #
export VISUAL=nvim
export EDITOR=nvim
export SUDO_EDITOR=nvim
export PATH=~/bin:~/.local/bin:$PATH

# -- GNOME keyring -- #
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# -- Offline IMAP Daemon -- #
offlineimap &> /dev/null &

[[ -f ~/.bashrc ]] && . ~/.bashrc &> /dev/null

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
    exec startx
fi

