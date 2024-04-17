#!/bin/bash
#
# .xinitrc - part of the Arch-Configurations project
# Copyright (C) 2023, Scott Wyman, development@scottwyman.me
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# Activate screen saver daemon
xscreensaver --no-splash &

# A compositor to reduce screen tearing
picom &

# Initialize status-bar values 
update-status-bar --all 

# Update just the date every second
while true;    
do    
    update-status-bar
    sleep 1
done &

# Update the weather every 5 minutes
while true;    
do    
    update-status-bar --weather
    sleep 600
done &

# Update most of the values every 15 seconds
while true;    
do    
    update-status-bar --volume --brightness --battery --network 
    sleep 15
    # Enables laptop monitor if no external monitors are connected
    enable-main-display
done &

# Share clipboard between host and VMs
spice-vdagent &

# Only launch dbus if it's not already running
[[ -z "$DBUS_SESSION_BUS_ADDRESS" ]] && dbus-launch

pulseaudio --start # Start the audio daemon
pamixer -u # Un-mute the speaker

# Mute speaker if screen locks. Unmute if unlocked and still muted
while true; 
do
    sleep 15
    
    xscreensaver-command -time | grep -i "locked" &>/dev/null \
        && pacmd suspend 1
done &

# If in a virtual machine, automatically set the resolution
xrandr | grep "Virtual-1 connected " && xrandr --output Virtual-1 --mode 1920x1080

# Set wallpaper
WALLPAPER=/home/$USER/.wallpaper
[[ -f $WALLPAPER ]] && feh --bg-scale $WALLPAPER

exec dwm
