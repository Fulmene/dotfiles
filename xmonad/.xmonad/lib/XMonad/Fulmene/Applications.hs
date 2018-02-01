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

myScreenShooter =
    myImageToClipboard "maim" `andThen`
    myImageSaveFromClipboard `andThen`
    myNotifySend "Screen captured"
mySelectionScreenShooter =
    myImageToClipboard "maim -s" `andThen`
    myImageSaveFromClipboard `andThen`
    myNotifySend "Screen selection captured"

myImageToClipboard image = image `pipe` "xclip -selection clipboard -t image/png"
myImageSaveFromClipboard = "xclip -o -selection clipboard -t image/png" `output` myScreenShotFileName
myScreenShotFileName = "~/Pictures/Screenshots/Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"

myToggleGammaCorrection = "pkill -USR1 redshift"
myToggleCompositor = "pkill compton" `orElse` "compton"

myNotifySend notif = "notify-send \"" ++ notif ++ "\""

-- Utility functions
pipe p1 p2 = p1 ++ " | " ++ p2
andThen p1 p2 = p1 ++ " && " ++ p2
orElse p1 p2 = p1 ++ " || " ++ p2
output prog out = prog ++ " > " ++ out

