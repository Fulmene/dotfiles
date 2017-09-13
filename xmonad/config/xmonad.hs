import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition

import XMonad.Layout.Grid
import XMonad.Layout.PerWorkspace
import XMonad.Layout.NoBorders

import XMonad.Actions.CycleWS

import XMonad.Util.EZConfig

import Data.List

main = do
    xmonad =<< statusBar myStatusBar myPP myToggleStruts (
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
        myPPHidden wid          = switchWorkspace wid $ [head wid]
        myPPHiddenNoWindows wid = xmobarColor "#6D757F" "" $ switchWorkspace wid $ [head wid]
        myPPUrgent wid          = xmobarColor "#FF7595" "" $ switchWorkspace wid $ [head wid]

        myPPOrder (ws:_:_:_) = [
                switchPreviousWorkspace "4" $ switchNextWorkspace "5" $ wrap (switchPreviousWorkspace "1" "<") ((switchNextWorkspace "1" ">")) . pad $ ws
            ]

myToggleStruts XConfig {XMonad.modMask = modMask} = (modMask, xK_b)


myTerminal = "termite"

myFocusFollowsMouse = False
myClickJustFocuses = False

myBorderWidth = 1
myNormalBorderColor = "#0C192A"
myFocusedBorderColor = "#F4DFD3"

myWorkspaces = [ "1 main", "2 web", "3 game", "4 media", "5 vm" ] ++ map show [6..9]

myModMask = mod1Mask

myKeys = windowKeys ++ applicationKeys ++ hardwareKeys where
    windowKeys = [
            ("M-S-h", prevWS) ,
            ("M-S-l", nextWS) ,
            ("C-M-h", shiftToPrev >> prevWS) ,
            ("C-M-l", shiftToNext >> nextWS)
        ]

    applicationKeys = [
            ("M-p", spawn myDesktopRunDialog) ,
            ("M-S-p", spawn myRunDialog) ,
            ("M-S-q", spawn myLogoutDialog) ,
            ("C-M-S-l", spawn myScreenLock) ,

            ("C-M-S-r", spawn "pkill -USR1 redshift") ,
            ("C-M-S-c", spawn "pkill compton || compton")
        ]

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

myDesktopRunDialog = "rofi -location 1 -yoffset 17 -combi-modi window,drun -show combi -modi combi -display-combi drun"
myRunDialog = "rofi -location 1 -yoffset 17 -show run"
myLogoutDialog = "rofi-logout"
myScreenLock = "cinnamon-screensaver-command --lock -m '" ++ myScreenLockMessage ++ "'"
myScreenLockMessage = "Exploring the power of freedom."


myLayoutHook =  onWorkspace "2 web" (webTall ||| Mirror webTall) $
                onWorkspaces [ "3 game", "4 media", "5 vm" ] (noBorders Full) $
                (mainTall ||| Mirror mainTall ||| Grid ||| Full) where
                    mainTall = Tall 2 (3/100) (1/2)
                    webTall = Tall 1 (3/100) (2/3)

myManageHook = insertPosition Below Newer <+> customManageHook <+> manageDocks <+> manageHook def
customManageHook = composeAll . concat $ [
        [ className =? c --> doShift "2 web" | c <- webClass ] ,
        [ title =? t --> doShift "3 game" | t <- gameTitle ] ,
        [ className =? c --> doShift "4 media" | c <- mediaClass ] ,
        [ className =? c --> doShift "5 vm" | c <- vmClass ] ,
        [ className =? c --> doFloat | c <- floatClass ]
    ] where
        floatClass = [ "Orage" ]
        webClass = [ "Firefox" , "Chromium" ]
        gameTitle = [ "Steam" , "Blizzard App" ]
        mediaClass = [ "mpv" ]
        vmClass = [ "VirtualBox" , "Genymotion", "Genymotion Player" ]

