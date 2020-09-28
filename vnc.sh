#!/bin/bash

echo "-----------------------------------Xvfb-------------------------------"
Xvfb :0 -screen 0 1200x800x16 +extension RANDR +extension GLX &

echo "Waiting for Xvfb to be ready..."
while ! xdpyinfo -display :0; do
    echo -n ''
    sleep 0.1
done

echo "-----------------------------------lxde-----------------------------"
DISPLAY=:0 startlxde &

echo "-----------------------------------x11vnc-----------------------------"
#TODO - -xrandr displays "Disabling -xrandr mode: display does not support X RANDR."
#I think something needs to be compiled into x11vnc for it to work?
x11vnc -forever -display :0 -passwd $X11VNC_PASSWORD 
#x11vnc -forever -display :0 -xrandr -ncache_cr -nowf -passwd $X11VNC_PASSWORD


