import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops

import XMonad.Layout.PerWorkspace
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders

import qualified XMonad.StackSet as StackSet

import XMonad.Util.EZConfig

import Graphics.X11.ExtraTypes.XF86

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
myPP = xmobarPP
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
            ("C-M-S-l", spawn myScreenLock)
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

myLayoutHook =  onWorkspaces [ "Game", "Media", "VM" ] (noBorders Full) $
                onWorkspace "Web" (webTall ||| Mirror webTall) $
                layoutHook def where
                    webTall = Tall 1 (3/100) (2/3)

myManageHook = customManageHook <+> (doF StackSet.swapDown) <+> manageDocks <+> manageHook def
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

