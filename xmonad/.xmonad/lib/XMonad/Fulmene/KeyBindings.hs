module XMonad.Fulmene.KeyBindings(myModMask, myRemoveKeys, myKeys, myToggleStruts) where

import XMonad
import XMonad.Actions.CycleWS
import XMonad.StackSet as W

import XMonad.Layout.ResizableTile

myToggleStruts XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myModMask = mod1Mask

myRemoveKeys =
    [    "M-S-<Return>" ,
         "M-p" ,
         "M-S-p" ,
         "M-S-q"
    ]

myKeys =
    [   ("M-h", prevWS) ,
        ("M-l", nextWS) ,
        ("M-S-h", shiftToPrev >> prevWS) ,
        ("M-S-l", shiftToNext >> nextWS) ,

        ("M-S-s", withFocused $ windows . W.sink) ,

        ("M-a", sendMessage MirrorExpand) ,
        ("M-z", sendMessage MirrorShrink)
    ]
