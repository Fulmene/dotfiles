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
    myToggleCompositor,
    myToggleDPMS,
    myNotifySend,

    myToggleXInput,
    mySetVolume,
    unmute,
    mute,
    toggle,
    lower,
    raise,

    mySwitchWorkspace,
    mySwitchWorkspaceIndex,

    pipe,
    andThen,
    orElse,
    input,
    output

) where

import XMonad.Fulmene.Management

import Data.List

-- Regular applications

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

myNotifySend notif = "notify-send" `input` notif

-- Hardware key applications

myToggleDPMS = "dpms-toggle"
myToggleXInput = "xinput-toggle"

mySetVolume mode = "amixer -q sset Master" `input` mode
unmute = "unmute"
mute = "mute"
toggle = "toggle"
lower = "2%-"
raise = "2%+"

-- Status bar application
mySwitchWorkspace wid = mySwitchWorkspaceMaybe (wid `elemIndex` myWorkspaces)

mySwitchWorkspaceIndex x = "wmctrl -s" `input` show x

mySwitchWorkspaceMaybe (Just x) = mySwitchWorkspaceIndex x
mySwitchWorkspaceMaybe Nothing = "false"

--currentWorkspace = "$(wmctrl -d | grep '*' | cut -d ' ' -f 1)"
--previousWorkspace = "$(( (" ++ currentWs ++ " + " ++ (show $ (length myWorkspaces) - 1) ++ ") % " ++ (show $ length myWorkspaces) ++ "))"
--nextWorkspace = "$(( (" ++ currentWs ++ " + 1" ++ ") % " ++ (show $ length myWorkspaces) ++ "))"

-- Utility functions
pipe p1 p2 = p1 ++ " | " ++ p2
andThen p1 p2 = p1 ++ " && " ++ p2
orElse p1 p2 = p1 ++ " || " ++ p2
input prog inp = prog ++ " \"" ++ inp ++ "\""
output prog out = prog ++ " > \"" ++ out ++ "\""

