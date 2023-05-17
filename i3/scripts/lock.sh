#!/bin/bash

img="$HOME/img/lockscreen.png"

SCREEN_RESOLUTION="$(xdpyinfo | grep dimensions | cut -d' ' -f7)"
BGCOLOR="#303446"

convert $img -gravity Center -background "$BGCOLOR" -extent "$SCREEN_RESOLUTION" RGB:- |  i3lock --raw "$SCREEN_RESOLUTION":rgb -i /dev/stdin
