#
# ~/.xinitrc
#

# -- System xinitrc -- #
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi
# -- End System xinitrc -- #

# -- QT5 config tool -- #
export QT_QPA_PLATFORMTHEME="qt5ct"

# -- VDPAU for intel card -- #
export VDPAU_DRIVER=va_gl

# -- Use IBus -- #
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
ibus-daemon -drx

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
start-pulseaudio-x11 &
xsetroot -cursor_name left_ptr &

compton &
bash ~/.wallpapers/wp_init.sh &
trayer --edge top --align right --widthtype pixel --width 82 --heighttype pixel --height 17 --SetDockType true --SetPartialStrut true --transparent true --alpha 51 --tint 0x0C192A &

redshift &
sleep 10 && nm-applet &
sleep 15 && kalu &

cinnamon-screensaver &

exec xmonad

