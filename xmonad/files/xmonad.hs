import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageHelpers

import XMonad.Layout.Grid
import XMonad.Layout.PerWorkspace
import XMonad.Layout.NoBorders

import qualified XMonad.StackSet as W

import XMonad.Actions.CycleWS

import XMonad.Util.EZConfig

import Data.List

main = do
    xmonad =<< statusBar myStatusBar myPP myToggleStruts (
            withUrgencyHook NoUrgencyHook $
            ewmh def {
                    terminal            = myTerminal ,
                    focusFollowsMouse   = myFocusFollowsMouse ,
                    clickJustFocuses    = myClickJustFocuses ,

                    borderWidth         = myBorderWidth ,
                    normalBorderColor   = myNormalBorderColor ,
                    focusedBorderColor  = myFocusedBorderColor ,

                    workspaces          = myWorkspaces ,
                    modMask             = myModMask ,

                    layoutHook          = myLayoutHook ,
                    manageHook          = myManageHook
                }
            `removeKeysP` myRemoveKeys
            `additionalKeysP` myKeys
        )

myStatusBar = "xmobar"

myPP = xmobarPP {
        ppCurrent = myPPCurrent ,
        ppHidden = myPPHidden ,
        ppHiddenNoWindows = myPPHiddenNoWindows ,
        ppUrgent = myPPUrgent ,
        ppWsSep = " " ,
        ppOrder = myPPOrder
    } where
        switchWorkspace wid = switchWorkspaceIndex (wid `elemIndex` myWorkspaces) where
            switchWorkspaceIndex (Just x) = wrap ("<action=`xdotool key alt+" ++ show (x+1) ++ "`>") "</action>"
            switchWorkspaceIndex Nothing  = id
        switchPreviousWorkspace button = wrap ("<action=`xdotool key alt+shift+h` button=" ++ button ++ ">") "</action>"
        switchNextWorkspace button = wrap ("<action=`xdotool key alt+shift+l` button=" ++ button ++ ">") "</action>"

        myPPCurrent wid         = xmobarColor "#F2CEA4" "" $ (wid ++ replicate padLength ' ') where padLength = (maximum $ map length myWorkspaces) - length wid
        myPPHidden wid          = xmobarColor "#F4DFD3" "" $switchWorkspace wid $ [head wid]
        myPPHiddenNoWindows wid = xmobarColor "#747474" "" $ switchWorkspace wid $ [head wid]
        myPPUrgent wid          = xmobarColor "#BF4D4D" "" $ switchWorkspace wid $ [head wid]

        myPPOrder (ws:_:_:_) = [
                xmobarColor "#D2A795" "" $ switchPreviousWorkspace "4" $ switchNextWorkspace "5" $ wrap (switchPreviousWorkspace "1" "[") ((switchNextWorkspace "1" "]")) . pad $ ws
            ]

myToggleStruts XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myTerminal = "termite"

myFocusFollowsMouse = False
myClickJustFocuses = False

myBorderWidth = 1
myNormalBorderColor = "#171717"
myFocusedBorderColor = "#F4DFD3"

myWorkspaces = [ "1 main", "2 web", "3 game", "4 media", "5 vm", "6 chat", "7 server", "8 office", "9 ide" ]

myModMask = mod1Mask

myRemoveKeys = [ "M-h", "M-j", "M-k", "M-l" ]

myKeys = windowKeys ++ applicationKeys ++ hardwareKeys where
    windowKeys = [
            ("M-S-j", windows W.focusDown) ,
            ("M-S-k", windows W.focusUp) ,
            ("C-M-j", windows W.swapDown) ,
            ("C-M-k", windows W.swapUp) ,

            ("M-S-h", prevWS) ,
            ("M-S-l", nextWS) ,
            ("C-M-h", shiftToPrev >> prevWS) ,
            ("C-M-l", shiftToNext >> nextWS)
        ]

    applicationKeys = [
            ("M-p", spawn desktopRunDialog) ,
            ("M-S-p", spawn runDialog) ,
            ("M-S-q", spawn logoutDialog) ,
            ("C-M-S-l", spawn screenLock) ,

            ("<Print>", spawn screenShooter) ,
            ("M-<Print>", spawn selectionScreenShooter) ,

            ("C-M-S-r", spawn "pkill -USR1 redshift") ,
            ("C-M-S-c", spawn "pkill compton || compton")
        ] where
        desktopRunDialog = "rofi -location 1 -yoffset 19 -combi-modi window,drun -show combi -modi combi -display-combi drun"
        runDialog = "rofi -location 1 -yoffset 19 -show run"
        logoutDialog = "rofi-logout"
        screenLock = "xset s activate"
        screenShooter = "maim | xclip -selection clipboard -t image/png && xclip -o -selection clipboard -t image/png > " ++ screenShooterFileName ++ " && notify-send \"Screen captured\""
        selectionScreenShooter = "maim -s | xclip -selection clipboard -t image/png && xclip -o -selection clipboard -t image/png > " ++ screenShooterFileName ++ " && notify-send \"Screen selection captured\""
        screenShooterFileName = "~/Pictures/Screenshots/Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"

    hardwareKeys = [
            ("C-M-S-d", spawn "dpms-toggle") ,
            ("<XF86TouchpadToggle>", spawn $ "xinput-toggle " ++ touchpad) ,
            ("<XF86AudioMute>", spawn $ setVolume toggle) ,
            ("<XF86AudioLowerVolume>", spawn $ (setVolume unmute) `andThen` (setVolume lower)) ,
            ("<XF86AudioRaiseVolume>", spawn $ (setVolume unmute) `andThen` (setVolume raise))
        ] where
        touchpad = "'FocalTechPS/2 FocalTech Touchpad'"
        setVolume mode = "amixer -q sset Master " ++ mode
        unmute = "unmute"
        mute = "mute"
        toggle = "toggle"
        lower = "2dB-"
        raise = "2dB+"
        andThen cmd1 cmd2 = cmd1 ++ " && " ++ cmd2

myLayoutHook =  onWorkspaces [ "2 web", "8 office", "9 ide" ] (tallTwoThird ||| Mirror tallTwoThird ||| Full) $
                onWorkspaces [ "3 game", "4 media", "5 vm" ] (smartBorders (Full ||| tallHalf)) $
                (tallHalf ||| Mirror tallHalf ||| Grid ||| Full) where
                    tallHalf = Tall 1 (3/100) (1/2)
                    tallTwoThird = Tall 1 (3/100) (2/3)

myManageHook = composeAll [
        workspaceManageHook ,
        manageDocks ,
        composeOne . concat $ [
                [ isDialog -?> doCenterFloat ] ,
                [ stringProperty "WM_WINDOW_ROLE" =? "pop-up" -?> doCenterFloat ] ,
                [ className =? c -?> doCenterFloat | c <- floatClass ] ,
                [ transience ] ,
                [ pure True -?> insertPosition Below Newer ]
            ] ,
        manageHook def
    ] where
        floatClass = [ "feh" , "Java" , "application.Main" ]
        workspaceManageHook = composeAll [ className =? c --> doShift ws | (ws, cs) <- wsClass, c <- cs ]
        wsClass = zip myWorkspaces [
                [] , -- 1 main
                [ "Firefox" , "Chromium" ] , -- 2 web
                [ "Steam" , "steam.exe" , "shadowverse.exe" , "magic-MagicMain" , "ygoproth experimental.exe" , "ygopro_test.exe" ] , -- 3 game
                [ "mpv" ] , -- 4 media
                [ "VirtualBox Machine" , "Genymotion Player" ] , -- 5 vm
                [ "discord", "Slack" ] , -- 6 chat
                [] , -- 7 server
                [ "libreoffice" , "libreoffice-writer" , "libreoffice-calc" , "libreoffice-impress" ] , -- 8 office
                [ "Eclipse" ]   -- 9 ide
            ]

