xrandr --dpi 96

ibus-daemon -drx

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
xsetroot -cursor_name left_ptr &

~/.fehbg
trayer --edge top --align right --widthtype percent --width 10 --heighttype pixel --height 19 --SetDockType true --SetPartialStrut true --transparent true --alpha 0 --tint 0x262626 &

xmobar ~/.xmobar/openbox &
xmobar ~/.xmobar/monitor &

numlockx &
redshift &

xset -dpms
xset s off

xinput disable 'FocalTechPS/2 FocalTech Touchpad'
