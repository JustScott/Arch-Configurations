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

# Stops xscreensaver from locking the screen while
#  audio's playing
prevent-screen-sleep &

# A compositor to reduce screen tearing
picom &

# Display battery percentage and date & time
while true;    
do    
    update-status-bar 
    sleep 30
    # Enables laptop monitor if no external monitors are connected
    enable-main-display
done &

#######
# In VM
##
spice-vdagent
########

# Only launch dbus if it's not already running
[[ -z "$DBUS_SESSION_BUS_ADDRESS" ]] && dbus-launch

pulseaudio --start # Start the audio daemon
pamixer -u # Un-mute the speaker

# If in a virtual machine, automatically set the resolution
if [[ $(xrandr) =~ "Virtual-1 connected " ]];
then
    xrandr --output Virtual-1 --mode 1920x1080
fi

# Set background
SCREENSAVER=/home/$USER/Pictures/Wallpapers/Nature/dark_red_moon.jpeg
if [ -f $SCREENSAVER ];
then
    feh --bg-scale $SCREENSAVER 
fi

exec dwm
