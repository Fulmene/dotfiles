#
# ~/.bash_profile
#

# -- Environment variables -- #
export EDITOR=nvim
export PATH=~/bin:~/.local/bin:$PATH

# -- Wine -- #
export WINEARCH=win32
export WINEDEBUG=-all
export FREETYPE_PROPERTIES="truetype:interpreter-version=35"

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
    exec startx
fi

