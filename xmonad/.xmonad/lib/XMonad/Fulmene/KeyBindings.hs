module XMonad.Fulmene.KeyBindings(myModMask, myRemoveKeys, myKeys, myToggleStruts) where

import XMonad
import XMonad.Actions.CycleWS

import XMonad.Fulmene.Applications

myModMask = mod1Mask

myRemoveKeys = []

myKeys = windowKeys ++ applicationKeys ++ hardwareKeys

windowKeys = [  ("M-h", prevWS) ,
                ("M-l", nextWS) ,
                ("M-S-h", shiftToPrev >> prevWS) ,
                ("M-S-l", shiftToNext >> nextWS)
             ]

applicationKeys = [ ("M-p", spawn myDesktopRunDialog) ,
                    ("M-S-p", spawn myRunDialog) ,
                    ("M-S-q", spawn myLogoutDialog) ,
                    ("C-M-S-l", spawn myScreenLock) ,

                    ("<Print>", spawn myScreenShooter) ,
                    ("M-<Print>", spawn mySelectionScreenShooter) ,

                    ("C-M-S-r", spawn myToggleGammaCorrection) ,
                    ("C-M-S-c", spawn myToggleCompositor)
                  ]

hardwareKeys = [ ("C-M-S-d", spawn "dpms-toggle") ,
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

myToggleStruts XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
