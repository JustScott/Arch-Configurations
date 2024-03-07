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

ACTION="Create soft links"
{
    mkdir -p ~/.config/nvim
    ln -sf $PWD/init.vim ~/.config/nvim
    ln -sf $PWD/init.vim ~/.vimrc

    ln -sf $PWD/.xinitrc ~/.xinitrc

    mkdir -p ~/.config/lf
    ln -sf $PWD/lf/{lfrc,previewer.sh} ~/.config/lf

    mkdir -p ~/.config/bat
    ln -sf $PWD/bat/config ~/.config/bat/config

    mkdir -p ~/.config/newsboat
    ln -sf $PWD/newsboat/config ~/.config/newsboat/config
    ln -sf $PWD/newsboat/urls ~/.config/newsboat/urls
} >/dev/null 2>>/tmp/archconfigurationerrors.log \
    && echo "[SUCCESS] $ACTION" \
    || echo "[FAIL] $ACTION... wrote error log to /tmp/archconfigurationerrors.log"

#
#  (note) You must run `:PlugInstall` from vim or neovim to install
#          your tools
#
# Install Vim-Plug for adding pluggins to vim and neovim
[ -f ~/.local/share/nvim/site/autoload/plug.vim ] || {
    ACTION="Download & Install vim-plug"
    {
        sh -c "curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim \
            --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    } >/dev/null 2>>/tmp/archconfigurationerrors.log \
        && echo "[SUCCESS] $ACTION" \
        || echo "[FAIL] $ACTION... wrote error log to /tmp/archconfigurationerrors.log"
}

ACTION="Download & Install vim plugins"
nvim -c "PlugInstall | qall" --headless >/dev/null 2>>/tmp/archconfigurationerrors.log \
    && echo "[SUCCESS] $ACTION" \
    || echo "[FAIL] $ACTION... wrote error log to /tmp/archconfigurationerrors.log"

ACTION="Configure global git user defaults"
{
    git config --global user.name JustScott
    git config --global user.email development@justscott.me
} >/dev/null 2>>/tmp/archconfigurationerrors.log \
    && echo "[SUCCESS] $ACTION" \
    || echo "[FAIL] $ACTION... wrote error log to /tmp/archconfigurationerrors.log"

bat --help &>/dev/null && {
    ACTION="Configure global git pager"
    git config --global core.pager "bat --paging=always --style=changes" \
        >/dev/null 2>>/tmp/archconfigurationerrors.log \
            && echo "[SUCCESS] $ACTION" \
            || echo "[FAIL] $ACTION... wrote error log to /tmp/archconfigurationerrors.log"
} || echo "Need to install bat to set it as git's default pager"
