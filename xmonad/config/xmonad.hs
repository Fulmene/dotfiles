import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks

import XMonad.Layout.PerWorkspace
import XMonad.Layout.OneBig
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders

import XMonad.Util.EZConfig

import qualified Data.Map as Map
import Control.Monad

main = do
    xmonad =<< statusBar myStatusBar myPP myToggleStruts (
        -- fullscreenSupport (
            def {
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
            -- )
        )

myStatusBar = "xmobar"
myPP = xmobarPP
myToggleStruts XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

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
myRunDialog = "rofi -location 1 -yoffset 30 -combi-modi window,drun -show combi -modi combi"
myLogoutDialog = "echo -e \"" ++ (unlines myLogoutOptions) ++ "\" | rofi -dmenu -p 'quit:' | { read option; systemctl $option; }"
    where myLogoutOptions = ["poweroff", "reboot", "suspend"]
myScreenLock = "cinnamon-screensaver-command --lock -m '" ++ myScreenLockMessage ++ "'"
myScreenLockMessage = "Exploring the power of freedom."

myLayoutHook = onWorkspaces ["Game", "Media", "VM"] (noBorders Full) $
               avoidStruts $ layoutHook def

myManageHook = customManageHook <+> manageDocks
customManageHook = composeAll . concat $ [
        -- TODO add manageHook
    ]

