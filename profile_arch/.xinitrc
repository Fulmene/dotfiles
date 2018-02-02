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

# -- Java options -- #
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
export _JAVA_AWT_WM_NONREPARENTING=1

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
xsetroot -cursor_name left_ptr &

compton &
~/.fehbg
trayer --edge top --align right --margin 190 --widthtype percent --width 27 --heighttype pixel --height 19 --SetDockType true --SetPartialStrut true --transparent true --alpha 51 --tint 0x262626 &

for bar in ~/.xmobar/*; do
    [ `basename $bar` != "xmonad" ] && xmobar $bar &
done

numlockx &
redshift &
nm-applet &
(sleep 10; kalu) &
(sleep 15; dropbox) &

xset -dpms
xset s off

xinput disable 'FocalTechPS/2 FocalTech Touchpad'

xss-lock -l -- screen-lock &

exec xmonad
