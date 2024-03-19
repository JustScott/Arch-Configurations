#!/bin/bash
#
# install.sh - part of the Arch-Configurations project
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

#
# Creates soft links to all of the configuration files in this repository
#  throughout the system.
#

nvim --version &>/dev/null && {
    ACTION="Create soft links for '$HOME/.vimrc' and '$HOME/.config/nvim'"
    {
        mkdir -p $HOME/.config/nvim
        ln -sf $PWD/init.vim $HOME/.config/nvim
        ln -sf $PWD/init.vim $HOME/.vimrc
    } >/dev/null 2>>/tmp/archconfigurationerrors.log \
            && echo "[SUCCESS] $ACTION" \
            || echo "[FAIL] $ACTION... wrote error log to /tmp/archconfigurationerrors.log"

    #
    #  (note) You must run `:PlugInstall` from vim or neovim to install
    #          your tools
    #
    # Install Vim-Plug for adding pluggins to vim and neovim
    [ -f $HOME/.local/share/nvim/site/autoload/plug.vim ] || {
        mkdir -p $HOME/.local/share/nvim/site/autoload
        ACTION="Download & Install vim-plug"
        echo -n "...$ACTION..."
        {
            curl -Lo $HOME/.local/share/nvim/site/autoload/plug.vim \
                https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            nvim -c "PlugInstall | qall" --headless
        } >/dev/null 2>>/tmp/archconfigurationerrors.log \
            && echo "[SUCCESS]" \
            || { "[FAIL] wrote error log to ~/miniarcherrors.log"; exit; }
    }
}


git --version &>/dev/null && {
    ACTION="Configure global git user defaults"
    {
        git config --global user.name JustScott
        git config --global user.email development@justscott.me
    } >/dev/null 2>>/tmp/archconfigurationerrors.log \
        && echo "[SUCCESS] $ACTION" \
        || echo "[FAIL] $ACTION... wrote error log to /tmp/archconfigurationerrors.log"
}

# We can presume X to be running if wayland isnt, and the $DISPLAY variable has value
[[ -z $WAYLAND_DISPLAY && $DISPLAY ]] && {
    ACTION="Create soft link to $HOME/.xinitrc"
    ln -sf $PWD/.xinitrc $HOME/.xinitrc >/dev/null 2>>/tmp/archconfigurationerrors.log \
        && echo "[SUCCESS] $ACTION" \
        || echo "[FAIL] $ACTION... wrote error log to /tmp/archconfigurationerrors.log"
} 

ACTION="Create soft link to '$HOME/.config/lf/{lfrc,previewer.sh}'"
lf --version &>/dev/null && {
    mkdir -p $HOME/.config/lf
    ln -sf $PWD/lf/{lfrc,previewer.sh} $HOME/.config/lf/
} >/dev/null 2>>/tmp/archconfigurationerrors.log \
    && echo "[SUCCESS] $ACTION" \
    || echo "[FAIL] $ACTION... wrote error log to /tmp/archconfigurationerrors.log"


bat --version &>/dev/null && {
    ACTION="Create soft link to '$HOME/.config/bat/config'"
    {
        mkdir -p $HOME/.config/bat
        ln -sf $PWD/bat/config $HOME/.config/bat/config
    } >/dev/null 2>>/tmp/archconfigurationerrors.log \
        && echo "[SUCCESS] $ACTION" \
        || echo "[FAIL] $ACTION... wrote error log to /tmp/archconfigurationerrors.log"


    git --version &>/dev/null && {
        ACTION="Configure global git pager as bat"
        git config --global core.pager "bat --paging=always --style=changes" \
            >/dev/null 2>>/tmp/archconfigurationerrors.log \
                && echo "[SUCCESS] $ACTION" \
                || echo "[FAIL] $ACTION... wrote error log to /tmp/archconfigurationerrors.log"
    }
} 

newsboat --version &>/dev/null && {
    ACTION="Create soft link to '$HOME/.config/newsboat/{config,urls}'"
    {
        mkdir -p $HOME/.config/newsboat
        ln -sf $PWD/newsboat/{config,urls} $HOME/.config/newsboat/
    } >/dev/null 2>>/tmp/archconfigurationerrors.log \
        && echo "[SUCCESS] $ACTION" \
        || echo "[FAIL] $ACTION... wrote error log to /tmp/archconfigurationerrors.log"
}
