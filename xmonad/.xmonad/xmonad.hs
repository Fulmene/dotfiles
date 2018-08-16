import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.UrgencyHook

import XMonad.Layout.Grid
import XMonad.Layout.PerWorkspace
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Fullscreen

import XMonad.Util.EZConfig

import XMonad.Fulmene.Applications
import XMonad.Fulmene.KeyBindings
import XMonad.Fulmene.Management
import XMonad.Fulmene.StatusBar

main = xmonad =<< statusBar myStatusBar myPP myToggleStruts
    (   withUrgencyHook NoUrgencyHook $
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
{-
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
-}
myLayoutHook =
    --fullscreenFull $
    onWorkspaces [ "2 web", "8 office", "9 ide" ] (mySpacing (tallTwoThird ||| Full)) $
    onWorkspaces [ "3 game", "4 media", "5 vm" ] (mySpacing tallTwoThird ||| smartBorders Full) $
    (mySpacing (tallHalf ||| Full))
tallHalf = Tall 2 (3/100) (1/2)
tallTwoThird = Tall 1 (3/100) (2/3)

mySpacing = spacingRaw False (Border 2 2 2 2) True (Border 2 2 2 2) True

