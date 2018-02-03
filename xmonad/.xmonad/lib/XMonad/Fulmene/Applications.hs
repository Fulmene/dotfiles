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
    currentWorkspace,
    previousWorkspace,
    nextWorkspace,

    pipe,
    andThen,
    orElse,
    input,
    stdoutRedir

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
myImageSaveFromClipboard = "xclip -o -selection clipboard -t image/png" `stdoutRedir` myScreenShotFileName
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
lower = "2dB-"
raise = "2dB+"

-- Status bar application
mySwitchWorkspace wid = mySwitchWorkspaceMaybe (wid `elemIndex` myWorkspaces)

mySwitchWorkspaceIndex x = "wmctrl -s" `input` show x

mySwitchWorkspaceMaybe (Just x) = mySwitchWorkspaceIndex x
mySwitchWorkspaceMaybe Nothing = "false"

currentWorkspace = "$(wmctrl -d | grep '*' | cut -d ' ' -f 1)"
previousWorkspace = "$(( (" ++ currentWorkspace ++ " + " ++ (show $ (length myWorkspaces) - 1) ++ ") % " ++ (show $ length myWorkspaces) ++ "))"
nextWorkspace = "$(( (" ++ currentWorkspace ++ " + 1" ++ ") % " ++ (show $ length myWorkspaces) ++ "))"

-- Utility functions
pipe cmd1 cmd2 = cmd1 ++ " | " ++ cmd2
andThen cmd1 cmd2 = cmd1 ++ " && " ++ cmd2
orElse cmd1 cmd2 = cmd1 ++ " || " ++ cmd2
input cmd inp = cmd ++ " \"" ++ inp ++ "\""
stdoutRedir cmd out = cmd ++ " > " ++ out

