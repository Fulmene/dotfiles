module XMonad.Fulmene.Layout(myLayoutHook) where

import XMonad

import XMonad.Layout.ResizableTile
import XMonad.Layout.SimplestFloat
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing

import XMonad.Layout.PerWorkspace

import XMonad.Actions.MouseResize
import XMonad.Layout.WindowArranger
import XMonad.Layout.BorderResize

import XMonad.Layout.Decoration
import XMonad.Layout.SimpleDecoration

myLayoutHook =
    simpleDeco myShrinker myTheme $
    mySpacing $
    lessBorders OnlyScreenFloat $ 
    onWorkspaces [ "2 web", "8 office", "9 ide" ] (myTall (2/3) ||| myMirrorTall (2/3) ||| myFull) $
    onWorkspaces [ "3 game", "7 float" ] (myFloat ||| myFull) $
    onWorkspaces [ "4 media", "5 vm" ] (noBorders Full) $
    myTall (1/2) ||| myMirrorTall (2/3) ||| myFull

mySpacing = spacingRaw False (Border 2 2 2 2) True (Border 2 2 2 2) True

bareTall ratio = ResizableTall 1 (3/100) ratio []
myTall ratio = bareTall ratio
myMirrorTall ratio = Mirror (bareTall ratio)
myFull = Full
myFloat = borderResize $ simplestFloat

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
                fontName = "xft:Droid Sans Mono:size=11:bold" ,
                decoWidth = 1920 ,
                decoHeight = 22
              }
