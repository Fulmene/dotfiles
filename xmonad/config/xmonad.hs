import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops

import XMonad.Layout.PerWorkspace
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders

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
            `additionalKeys` myKeys
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
            ((mod1Mask, xK_p), spawn myDesktopRunDialog) ,
            ((mod1Mask .|. shiftMask, xK_p), spawn myRunDialog) ,
            ((mod1Mask .|. shiftMask, xK_q), spawn myLogoutDialog) ,
            ((mod4Mask, xK_l), spawn myScreenLock)
        ]
    hardwareKeys = [
            ((0, xF86XK_TouchpadToggle), spawn $ "xinput-toggle " ++ touchpad) ,
            ((0, xF86XK_AudioMute), spawn $ mute "toggle") ,
            ((0, xF86XK_AudioLowerVolume), spawn $ mute "false" ++ "; " ++ lowerVolume) ,
            ((0, xF86XK_AudioRaiseVolume), spawn $ mute "false" ++ "; " ++ raiseVolume)
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

myManageHook = customManageHook <+> manageDocks <+> manageHook def
customManageHook = composeAll . concat $ [
        -- TODO add manageHook
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

