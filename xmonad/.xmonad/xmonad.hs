import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.RefocusLast
import XMonad.Hooks.UrgencyHook

import XMonad.Util.EZConfig

import XMonad.Fulmene.Applications
import XMonad.Fulmene.KeyBindings
import XMonad.Fulmene.Layout
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

                handleEventHook     = refocusLastWhen refocusingIsActive <+> handleEventHook def <+> fullscreenEventHook ,
                layoutHook          = refocusLastLayoutHook $ myLayoutHook ,
                manageHook          = myManageHook
            }
        `removeKeysP` myRemoveKeys
        `additionalKeysP` myKeys
    )

