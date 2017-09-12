import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops

import XMonad.Layout.Grid
import XMonad.Layout.PerWorkspace
import XMonad.Layout.NoBorders

import XMonad.StackSet(swapDown)

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
        ppWsSep = "" ,
        ppOrder = myPPOrder
    } where
        filterWorkspace wid = if wid `elem` myWorkspaces then wid else ""
        switchWorkspace wid = switchWorkspaceIndex (wid `elemIndex` myWorkspaces) where
            switchWorkspaceIndex (Just x) = wrap ("<action=`xdotool key alt+" ++ show (x+1) ++ "`>") "</action>"
            switchWorkspaceIndex Nothing  = id
        myPPCurrent wid = xmobarColor "#F2CEA4" "" $ wrap "[" "]" $ filterWorkspace wid
        myPPHidden wid = pad $ switchWorkspace wid $ filterWorkspace wid
        myPPHiddenNoWindows wid = pad $ xmobarColor "#6D757F" "" $ switchWorkspace wid $ filterWorkspace wid
        myPPUrgent wid = xmobarColor "#FF7595" "" $ wrap ">" "<" $ switchWorkspace wid $ filterWorkspace wid
        myPPOrder (ws:_:_:_) = [ws]
myToggleStruts XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myTerminal = "termite"

myFocusFollowsMouse = False
myClickJustFocuses = False

myBorderWidth = 1
myNormalBorderColor = "#0C192A"
myFocusedBorderColor = "#F4DFD3"

myWorkspaces = [ "Work", "Web", "Game", "Media", "VM" ]
myModMask = mod1Mask
myKeys = applicationKeys ++ hardwareKeys where
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

myLayoutHook =  onWorkspace "Web" (webTall ||| Mirror webTall) $
                onWorkspaces [ "Game", "Media" ] (noBorders Full) $
                onWorkspace "VM" (Grid ||| noBorders Full) $
                layoutHook def where
                    webTall = Tall 1 (3/100) (2/3)

myManageHook = customManageHook <+> (doF swapDown) <+> manageDocks <+> manageHook def
customManageHook = composeAll . concat $ [
        [ className =? c --> doShift "Web" | c <- webClass ] ,
        [ title =? t --> doShift "Game" | t <- gameTitle ] ,
        [ className =? c --> doShift "Media" | c <- mediaClass ] ,
        [ className =? c --> doShift "VM" | c <- vmClass ] ,
        [ className =? c --> doFloat | c <- floatClass ]
    ] where
        floatClass = [ "Orage" ]
        webClass = [ "Firefox" , "Chromium" ]
        gameTitle = [ "Steam" , "Blizzard App" ]
        mediaClass = [ "mpv" ]
        vmClass = [ "VirtualBox" , "Genymotion", "Genymotion Player" ]

