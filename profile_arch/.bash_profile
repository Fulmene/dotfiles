#
# ~/.bash_profile
#

# -- Environment variables -- #
export VISUAL=nvim
export EDITOR=nvim
export TERMINAL='kitty --single-instance'
export SUDO_EDITOR=nvim
export PATH=~/bin:~/.local/bin:$PATH
export AUR_PAGER=ranger

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets)
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh

[[ -f ~/.bashrc ]] && . ~/.bashrc &> /dev/null

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ]; then
    if [ "$XDG_VTNR" -eq 1 ]; then
        # -- VDPAU for intel card -- #
        export VDPAU_DRIVER=va_gl

        # -- Java options -- #
        export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"

        export QT_QPA_PLATFORM="wayland;xcb"

        # -- Themes -- #
        export QT_QPA_PLATFORMTHEME=qt5ct

        # -- Input Method -- #
        export XMODIFIERS=@im=fcitx
        export QT_IM_MODULE=fcitx
        export SDL_IM_MODULE=fcitx
        export GLFW_IM_MODULE=ibus # The value of this environment variable can only be ibus

        # -- Set XDG_CURRENT_DESKTOP to the name of the compositor -- #
        export XDG_CURRENT_DESKTOP='river'

        exec river
    fi
fi
