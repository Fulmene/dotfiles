module XMonad.Fulmene.StatusBar(myStatusBar, myPP) where

import XMonad.Hooks.DynamicLog

import XMonad.Fulmene.Applications
import XMonad.Fulmene.Management

import Data.List

myStatusBar = "xmobar ~/.xmobar/xmonad"

myPP = xmobarPP
    {   ppCurrent = myPPCurrent ,
        ppHidden = myPPHidden ,
        ppHiddenNoWindows = myPPHiddenNoWindows ,
        ppUrgent = myPPUrgent ,
        ppSep = " " ,
        ppWsSep = " " ,
        ppOrder = myPPOrder
    }

mouseAction cmd button str =
    wrap
        (wrap "<" ">" ((wrap "action=`" "` " cmd) ++ (wrap "button=" "" button)))
        "</action>"
        str

myPPCurrent wid =
    xmobarColor "#F2CEA4" "" $
    (wid ++ replicate padLength ' ') where padLength = (maximum $ map length myWorkspaces) - length wid
myPPHidden wid =
    xmobarColor "#F4DFD3" "" $
    mouseAction (mySwitchWorkspace wid) "1" $
    [head wid]
myPPHiddenNoWindows wid =
    xmobarColor "#747474" "" $
    mouseAction (mySwitchWorkspace wid) "1" $
    [head wid]
myPPUrgent wid =
    xmobarColor "#BF4D4D" "" $
    mouseAction (mySwitchWorkspace wid) "1" $
    [head wid]

myWorkspacesPP ws =
    xmobarColor "#D2A795" "" $
    mouseAction (mySwitchWorkspaceIndex previousWorkspace) "4" $
    mouseAction (mySwitchWorkspaceIndex nextWorkspace) "5" $
    wrap 
        (mouseAction (mySwitchWorkspaceIndex previousWorkspace) "1" "[")
        (mouseAction (mySwitchWorkspaceIndex nextWorkspace) "1" "]") $
    pad $ ws

myPPOrder (ws:layout:title:_) =
    [   ' ' : (myWorkspacesPP ws),
        map head $ words layout ,
        title
    ]

