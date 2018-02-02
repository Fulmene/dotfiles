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
        ppTitle = myPPTitle ,
        ppTitleSanitize = myPPTitleSanitize ,
        ppOrder = myPPOrder
    }

mouseAction cmd button str =
    wrap
        (wrap "<" ">" ((wrap "action=`" "` " cmd) ++ (wrap "button=" "" button)))
        "</action>"
        str

myPPCurrent wid =
    xmobarColor "#DFAF87" "" $
    (wid ++ replicate padLength ' ') where padLength = (maximum $ map length myWorkspaces) - length wid
myPPHidden wid =
    xmobarColor "#FFFFDF" "" $
    mouseAction (mySwitchWorkspace wid) "1" $
    [head wid]
myPPHiddenNoWindows wid =
    xmobarColor "#767676" "" $
    mouseAction (mySwitchWorkspace wid) "1" $
    [head wid]
myPPUrgent wid =
    xmobarColor "#D75F5F" "" $
    mouseAction (mySwitchWorkspace wid) "1" $
    [head wid]

myPPTitle title = xmobarColor "#87AFAF" "" title
myPPTitleSanitize title = shorten 40 title

myWorkspacesPP ws =
    xmobarColor "#AF875F" "" $
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

