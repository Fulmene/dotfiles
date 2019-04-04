module XMonad.Fulmene.Layout(myLayoutHook) where

import XMonad

import XMonad.Layout.ResizableTile
import XMonad.Layout.SimpleFloat
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing

import XMonad.Layout.PerWorkspace

import XMonad.Actions.MouseResize
import XMonad.Layout.WindowArranger
import XMonad.Layout.BorderResize

import XMonad.Layout.Decoration
import XMonad.Layout.TabBarDecoration

myLayoutHook =
    onWorkspaces [ "2 web", "8 office", "9 ide" ] (myMirrorTall ||| myFull) $
    onWorkspaces [ "3 game", "7 float" ] (myFloat ||| myFull) $
    onWorkspaces [ "4 media", "5 vm" ] (noBorders Full) $
    myTallHalf ||| myFull

mySpacing = spacingRaw False (Border 2 2 2 2) True (Border 2 2 2 2) True

myTallHalf = mySpacing $ myTabBar $ ResizableTall 2 (3/100) (1/2) []
myMirrorTall = mySpacing $ myTabBar $ Mirror (ResizableTall 1 (3/100) (3/5) [])
myFull = mySpacing $ myTabBar $ Full
myFloat = mySpacing $ borderResize $ simpleFloat' myShrinker myTheme

myTabBar :: l Window -> ModifiedLayout (Decoration TabBarDecoration DefaultShrinker) (ModifiedLayout ResizeScreen l) Window
myTabBar = tabBar myShrinker myTheme Top . resizeVertical (fromIntegral $ decoHeight myTheme)

myShrinker = shrinkText

myTheme = def {
                activeColor = "#404040" ,
                inactiveColor = "#606060" ,
                urgentColor = "#404040" ,
                activeBorderColor = "#DFAF87" ,
                inactiveBorderColor = "#FFFFDF" ,
                urgentBorderColor = "#D75F5F" ,
                activeTextColor = "#DFAF87" ,
                inactiveTextColor = "#FFFFDF" ,
                urgentTextColor = "#D75F5F" ,
                fontName = "xft:Droid Sans Mono:size=13:bold" ,
                decoHeight = 20
              }
