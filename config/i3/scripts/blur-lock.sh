#!/usr/bin/env bash

PICTURE=/tmp/i3lock.png
scrot $PICTURE
GOAL_SIZE=$(identify -format '%wx%h' $PICTURE)
convert -scale 2% -resize $GOAL_SIZE\! $PICTURE $PICTURE
i3lock -i $PICTURE
rm $PICTURE
