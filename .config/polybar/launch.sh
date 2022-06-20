#!/bin/sh

killall -q polybar

polybar main &
polybar secondary

echo "Polybar launched...

