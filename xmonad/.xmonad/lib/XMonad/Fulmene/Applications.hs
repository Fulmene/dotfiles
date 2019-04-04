module XMonad.Fulmene.Applications(
    myTerminal,
    myDesktopRunDialog,
    myRunDialog,
    myTerminalDialog,
    myLogoutDialog,
    myScreenLock,
    myScreenShooter,
    mySelectionScreenShooter,
    myToggleGammaCorrection,
    myToggleCompositor,
    myToggleDPMS,
    myNotifySend,

    myToggleXInput,
    touchpad,

    mySetVolume,
    unmuteV,
    muteV,
    toggleV,
    lowerV,
    raiseV,

    mySetBrightness,
    setB,
    increaseB,
    decreaseB,

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

myDesktopRunDialog = "rofi -location 1 -xoffset 7 -yoffset 26 -combi-modi window,drun -show combi -modi combi -display-combi drun -show-icons"
myRunDialog = "rofi -location 1 -xoffset 7 -yoffset 26 -show run"
myTerminalDialog = "rofi-termdir"
myLogoutDialog = "rofi-logout"

myScreenLock = "xset s activate"

myScreenShooter = "screenshot"
mySelectionScreenShooter = "screenshot-selection"

myToggleGammaCorrection = "pkill -USR1 redshift"
myToggleCompositor = "pkill compton" `orElse` "compton"

myNotifySend notif = "notify-send" `input` notif

-- Hardware key applications

myToggleDPMS = "dpms-toggle"
myToggleXInput = "xinput-toggle"
touchpad = "ETPS/2 Elantech Touchpad"

mySetVolume mode = "amixer -q sset Master" `input` mode
unmuteV = "unmute"
muteV = "mute"
toggleV = "toggle"
lowerV = "2dB-"
raiseV = "2dB+"

mySetBrightness mode percent = "xbacklight" `input` mode `input` (show percent)
setB = "-set"
increaseB = "-inc"
decreaseB = "-dec"

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
