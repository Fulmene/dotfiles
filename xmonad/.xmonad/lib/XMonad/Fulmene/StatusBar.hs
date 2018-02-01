module XMonad.Fulmene.StatusBar(myStatusBar, myPP) where

import XMonad.Hooks.DynamicLog

import XMonad.Fulmene.Management

import Data.List

myStatusBar = "xmobar ~/.xmobar/xmonad"

myPP = xmobarPP {
        ppCurrent = myPPCurrent ,
        ppHidden = myPPHidden ,
        ppHiddenNoWindows = myPPHiddenNoWindows ,
        ppUrgent = myPPUrgent ,
        ppSep = " " ,
        ppWsSep = " " ,
        ppOrder = myPPOrder
    } where
        switchWorkspace wid = switchWorkspaceIndex (wid `elemIndex` myWorkspaces) where
            switchWorkspaceIndex (Just x) = wrap ("<action=`wmctrl -s " ++ show x ++ "`>") "</action>"
            switchWorkspaceIndex Nothing  = id
        switchPreviousWorkspace button = wrap ("<action=`wmctrl -s " ++ previousWs ++ "` button=" ++ button ++ ">") "</action>"
        switchNextWorkspace button = wrap ("<action=`wmctrl -s " ++ nextWs ++ "` button=" ++ button ++ ">") "</action>"
        currentWs = "$(wmctrl -d | grep '*' | cut -d ' ' -f 1)"
        previousWs = "$(( (" ++ currentWs ++ " + " ++ (show $ (length myWorkspaces) - 1) ++ ") % " ++ (show $ length myWorkspaces) ++ "))"
        nextWs = "$(( (" ++ currentWs ++ " + 1" ++ ") % " ++ (show $ length myWorkspaces) ++ "))"

        myPPCurrent wid         = xmobarColor "#F2CEA4" "" $ (wid ++ replicate padLength ' ') where padLength = (maximum $ map length myWorkspaces) - length wid
        myPPHidden wid          = xmobarColor "#F4DFD3" "" $switchWorkspace wid $ [head wid]
        myPPHiddenNoWindows wid = xmobarColor "#747474" "" $ switchWorkspace wid $ [head wid]
        myPPUrgent wid          = xmobarColor "#BF4D4D" "" $ switchWorkspace wid $ [head wid]

        myPPOrder (ws:layout:title:_) = [
                xmobarColor "#D2A795" "" $ switchPreviousWorkspace "4" $ switchNextWorkspace "5" $ wrap (switchPreviousWorkspace "1" "[") ((switchNextWorkspace "1" "]")) . pad $ ws ,
                map head $ words layout ,
                title
            ]

