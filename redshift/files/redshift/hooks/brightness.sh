#!/bin/sh

brightness_day=100
brightness_transition=80
brightness_night=50
fade_time=60000
fps=60

case $1 in
    period-changed)
        case $3 in
            daytime)
                xbacklight -set $brightness_day -time $fade_time -fps $fps
                ;;
            transition)
                xbacklight -set $brightness_transition -time $fade_time -fps $fps
                ;;
            night)
                xbacklight -set $brightness_night -time $fade_time -fps $fps
                ;;
        esac
        ;;
esac
