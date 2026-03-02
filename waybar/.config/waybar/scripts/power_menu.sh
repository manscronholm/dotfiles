#!/bin/bash

choice=$(echo -e " Power Off\n Reboot\n Logout" | wofi --dmenu --cache-file /dev/null -p "Select action")

case "$choice" in
    *"Power Off"*)
        systemctl poweroff
        ;;
    *"Reboot"*)
        systemctl reboot
        ;;
    *"Logout"*)
        hyprctl dispatch exit
        ;;
esac
