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

# -- GNOME keyring -- #
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

[[ -f ~/.bashrc ]] && . ~/.bashrc &> /dev/null

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ]; then
    if [ "$XDG_VTNR" -eq 1 ]; then
        # -- VDPAU for intel card -- #
        export VDPAU_DRIVER=va_gl

        # -- Java options -- #
        export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"

        # -- Wayland environment variables -- #
        systemctl --user import-environment DISPLAY WAYLAND_DISPLAY
        hash dbus-update-activation-environment 2>/dev/null && \
            dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY
        export QT_QPA_PLATFORM=wayland

        # -- Themes -- #
        export QT_QPA_PLATFORMTHEME=qt5ct

        # -- XKB keyboard layouts -- #
        export XKB_DEFAULT_LAYOUT='us(altgr-intl),th'
        export XKB_DEFAULT_OPTIONS='grp:win_space_toggle'

        # -- Set XDG_CURRENT_DESKTOP to the name of the compositor -- #
        export XDG_CURRENT_DESKTOP='river'

        exec river
    fi
fi
