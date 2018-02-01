module XMonad.Fulmene.Management(myWorkspaces, myManageHook) where

import XMonad

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.InsertPosition

myWorkspaces =
    [ "1 main",
      "2 web",
      "3 game",
      "4 media",
      "5 vm",
      "6 chat",
      "7 server",
      "8 office",
      "9 ide"
    ]

myManageHook = composeAll
    [ workspaceManageHook ,
      manageDocks ,
      composeOne . concat $ [
          [ isDialog -?> doCenterFloat ] ,
          [ stringProperty "WM_WINDOW_ROLE" =? "pop-up" -?> doCenterFloat ] ,
          [ className =? c -?> doCenterFloat | c <- floatClass ] ,
          [ transience ] ,
          [ pure True -?> insertPosition Below Newer ]
      ] ,
      manageHook def
    ]

floatClass = [ "feh" , "Java" , "application.Main" ]
workspaceManageHook = composeAll [ className =? c --> doShift ws | (ws, cs) <- wsClass, c <- cs ]
wsClass = zip myWorkspaces
    [ [] , -- 1 main
      [ "Firefox" , "Chromium" ] , -- 2 web
      [ "Steam" , "Wine" , "magic-MagicMain" ] , -- 3 game
      [ "mpv" ] , -- 4 media
      [ "VirtualBox Machine" , "Genymotion Player" ] , -- 5 vm
      [ "discord", "Slack" ] , -- 6 chat
      [] , -- 7 server
      [ "libreoffice" , "libreoffice-writer" , "libreoffice-calc" , "libreoffice-impress" ] , -- 8 office
      [ "Eclipse" ]   -- 9 ide
    ]

