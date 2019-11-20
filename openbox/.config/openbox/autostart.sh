xrandr --dpi 96

ibus-daemon -drx

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
xsetroot -cursor_name left_ptr &

~/.fehbg
trayer --edge top --align right --widthtype percent --width 10 --heighttype pixel --height 22 --SetDockType true --SetPartialStrut true --transparent true --alpha 0 --tint 0x262626 &

xmobar ~/.xmobar/openbox &
xmobar ~/.xmobar/monitor &

numlockx &

xset -dpms
xset s off

xinput disable 'CUST0001:00 04F3:30AA Touchpad' || xinput disable 'ETPS/2 Elantech Touchpad'

sxhkd -r /dev/null &
