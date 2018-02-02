module XMonad.Fulmene.KeyBindings(myModMask, myRemoveKeys, myKeys, myToggleStruts) where

import XMonad
import XMonad.Actions.CycleWS

import XMonad.Fulmene.Applications

myToggleStruts XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myModMask = mod1Mask

myRemoveKeys = []

myKeys = windowKeys ++ applicationKeys ++ hardwareKeys

windowKeys =
    [   ("M-h", prevWS) ,
        ("M-l", nextWS) ,
        ("M-S-h", shiftToPrev >> prevWS) ,
        ("M-S-l", shiftToNext >> nextWS)
    ]

applicationKeys =
    [   ("M-p", spawn myDesktopRunDialog) ,
        ("M-S-p", spawn myRunDialog) ,
        ("M-S-q", spawn myLogoutDialog) ,
        ("C-M-S-l", spawn myScreenLock) ,

        ("<Print>", spawn myScreenShooter) ,
        ("M-<Print>", spawn mySelectionScreenShooter) ,

        ("C-M-S-r", spawn myToggleGammaCorrection) ,
        ("C-M-S-c", spawn myToggleCompositor) ,
        ("C-M-S-d", spawn myToggleDPMS)
    ]

hardwareKeys =
    [   ("<XF86TouchpadToggle>", spawn $ myToggleXInput `input` touchpad) ,
        ("<XF86AudioMute>", spawn $ mySetVolume toggle) ,
        ("<XF86AudioLowerVolume>", spawn $ (mySetVolume unmute) `andThen` (mySetVolume lower)) ,
        ("<XF86AudioRaiseVolume>", spawn $ (mySetVolume unmute) `andThen` (mySetVolume raise))
    ]
touchpad = "FocalTechPS/2 FocalTech Touchpad"
