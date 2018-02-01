module XMonad.Fulmene.Applications(
    myTerminal,
    myDesktopRunDialog,
    myRunDialog,
    myLogoutDialog,
    myScreenLock,
    myScreenShooter,
    mySelectionScreenShooter,
    myScreenShotFileName,
    myToggleGammaCorrection,
    myToggleCompositor
) where

myTerminal = "termite"

myDesktopRunDialog = "rofi -location 1 -xoffset 6 -yoffset 25 -combi-modi window,drun -show combi -modi combi -display-combi drun"
myRunDialog = "rofi -location 1 -xoffset 6 -yoffset 25 -show run"
myLogoutDialog = "rofi-logout"

myScreenLock = "xset s activate"

myScreenShooter = "maim | xclip -selection clipboard -t image/png && xclip -o -selection clipboard -t image/png > " ++ myScreenShotFileName ++ " && notify-send \"Screen captured\""
mySelectionScreenShooter = "maim -s | xclip -selection clipboard -t image/png && xclip -o -selection clipboard -t image/png > " ++ myScreenShotFileName ++ " && notify-send \"Screen selection captured\""
myScreenShotFileName = "~/Pictures/Screenshots/Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"

myToggleGammaCorrection = "pkill -USR1 redshift"
myToggleCompositor = "pkill compton || compton"

