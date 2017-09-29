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

myWorkspaces = [ "1 main", "2 web", "3 game", "4 media", "5 vm", "6 chat", "7", "8 office", "9 ide" ]

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
            ("<XF86TouchpadToggle>", spawn $ "xinput-toggle " ++ touchpad) ,
            ("<XF86AudioMute>", spawn $ mute "toggle") ,
            ("<XF86AudioLowerVolume>", spawn $ mute "false" ++ " && " ++ lowerVolume) ,
            ("<XF86AudioRaiseVolume>", spawn $ mute "false" ++ " && " ++ raiseVolume)
        ] where
        touchpad = "'FocalTechPS/2 FocalTech Touchpad'"
        mute mode = "pactl set-sink-mute 0 " ++ mode
        lowerVolume = "pactl set-sink-volume 0 -5%"
        raiseVolume = "pactl set-sink-volume 0 +5%"

myLayoutHook =  onWorkspace "2 web" (webTall ||| Mirror webTall) $
                onWorkspaces [ "3 game", "4 media", "5 vm" ] (noBorders Full) $
                (mainTall ||| Mirror mainTall ||| Grid ||| Full) where
                    mainTall = Tall 2 (3/100) (1/2)
                    webTall = Tall 1 (3/100) (2/3)

myManageHook = composeAll [
        composeOne [ transience, return True -?> insertPosition Below Newer ] ,
        customManageHook ,
        manageDocks ,
        manageHook def
    ]
customManageHook = composeAll . concat $ [
        [ className =? c --> doShift ws | (ws, cs) <- wsClass, c <- cs ] ,
        [ className =? c --> doCenterFloat | c <- floatClass ] ,
        [ isDialog --> doFloat ]
    ] where
        floatClass = [ "feh" , "shadowverse.exe" ]
        wsClass = zip myWorkspaces [
                [] , -- 1 main
                [ "Firefox" , "Chromium" ] , -- 2 web
                [ "Steam" , "steam.exe" , "shadowverse.exe" ] , -- 3 game
                [ "mpv" ] , -- 4 media
                [ "VirtualBox" , "Genymotion" , "Genymotion Player" ] , -- 5 vm
                [ "discord", "Slack" ] , -- 6 chat
                [] , -- 7
                [ "libreoffice" , "libreoffice-writer" , "libreoffice-calc" , "libreoffice-impress" ] , -- 8 office
                [ "Eclipse" ]   -- 9 ide
            ]

