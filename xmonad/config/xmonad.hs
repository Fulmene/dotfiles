import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig

import qualified Data.Map as Map
import Control.Monad

main = do
    xmonad =<< statusBar myStatusBar myPP myToggleStruts (
        def {
            terminal            = myTerminal ,
            focusFollowsMouse   = myFocusFollowsMouse ,
            clickJustFocuses    = myClickJustFocuses ,

            borderWidth         = myBorderWidth ,
            normalBorderColor   = myNormalBorderColor ,
            focusedBorderColor  = myFocusedBorderColor ,

            workspaces          = myWorkspaces ,
            modMask             = myModMask ,

            startupHook         = myStartupHook ,
            layoutHook          = myLayoutHook ,
            manageHook          = myManageHook
            }
            `additionalKeys` myKeys
        )

myStatusBar = "xmobar"
myPP = xmobarPP
myToggleStruts XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
mySystemTray = "trayer --edge top --align right --widthtype pixel --width 137 --heighttype pixel --height 30 --SetDockType true --SetPartialStrut true --transparent true --alpha 51 --tint 0x0C192A --expand true"
myCompositor = "compton"
myDesktopBackground = "wal -R"
myScreenSaver = "cinnamon-screensaver"

myTerminal = "xfce4-terminal"

myFocusFollowsMouse = False
myClickJustFocuses = False

myBorderWidth = 1
myNormalBorderColor = "#0C192A"
myFocusedBorderColor = "#F4DFD3"

myWorkspaces = [ "Work", "Web", "Game", "Media", "VM" ]
myModMask = mod1Mask
myKeys = [
    -- Run applications
    ((mod1Mask .|. shiftMask, xK_r), spawn myRunDialog) ,
    ((mod1Mask .|. shiftMask, xK_q), spawn myLogoutDialog) ,
    ((mod4Mask, xK_l), spawn myScreenLock)
    ]
myRunDialog = "rofi -location 1 -yoffset 30 -combi-modi window,drun -show combi -modi combi -p 'Application> '"
myLogoutDialog = "echo -e \"" ++ (unlines myLogoutOptions) ++ "\" | rofi -dmenu -p 'Quit> ' | { read option; systemctl $option; }"
    where myLogoutOptions = ["poweroff", "reboot", "suspend"]
myScreenLock = "cinnamon-screensaver-command --lock -m '" ++ myScreenLockMessage ++ "'"
myScreenLockMessage = "Exploring the power of freedom."

myStartupHook = mapM_ spawn [
        "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1" , -- Polkit agent
        "start-pulseaudio-x11" , -- PulseAudio
        "xsetroot -cursor_name left_ptr" , -- Mouse cursor on root window
        myCompositor ,
        myDesktopBackground ,
        mySystemTray ,
        myStatusBar ,
        sleep 10 ++ "nm-applet" ,
        sleep 15 ++ "kalu" ,
        "redshift" ,
        myScreenSaver
    ]
    where sleep n = "sleep " ++ show n ++ " && "

myLayoutHook = avoidStruts $ layoutHook def

myManageHook = customManageHook <+> manageDocks
customManageHook = composeAll . concat $ [
        -- TODO add manageHook
    ]

