import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.UrgencyHook

import XMonad.Layout.Grid
import XMonad.Layout.PerWorkspace
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Fullscreen

import qualified XMonad.StackSet as W

import XMonad.Util.EZConfig

import XMonad.Fulmene.Applications
import XMonad.Fulmene.KeyBindings
import XMonad.Fulmene.Management
import XMonad.Fulmene.StatusBar

import Data.List

main = xmonad =<< statusBar myStatusBar myPP myToggleStruts
    (   withUrgencyHook NoUrgencyHook $
        fullscreenSupport $
        ewmh def
            {   terminal            = myTerminal ,
                focusFollowsMouse   = False ,
                clickJustFocuses    = False ,

                borderWidth         = 1 ,
                normalBorderColor   = "#303030" ,
                focusedBorderColor  = "#DFDFAF" ,

                workspaces          = myWorkspaces ,
                modMask             = myModMask ,

                layoutHook          = myLayoutHook ,
                manageHook          = myManageHook
            }
        `removeKeysP` myRemoveKeys
        `additionalKeysP` myKeys
    )

myLayoutHook =
    fullscreenFull $
    onWorkspaces [ "2 web", "8 office", "9 ide" ] (spacingWithEdge 3 (tallTwoThird ||| Mirror tallTwoThird ||| Full)) $
    onWorkspaces [ "3 game", "4 media", "5 vm" ] (spacingWithEdge 3 tallHalf ||| smartBorders Full) $
    (spacingWithEdge 3 (tallHalf ||| Mirror tallHalf ||| Grid ||| Full))
tallHalf = Tall 2 (3/100) (1/2)
tallTwoThird = Tall 1 (3/100) (2/3)

