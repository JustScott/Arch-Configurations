#!/bin/bash
#
# install.sh - part of the Arch-Configurations project
# Copyright (C) 2023-2025, JustScott, development@justscott.me
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

if [[ $(basename $PWD) != "Arch-Configurations" ]]
then
    printf "\e[31m%s\e[0m\n" \
        "[Error] Please run script from the Arch-Configurations base directory"
    exit 1
fi

source ./shared_lib

{
    extension_path="$PWD/bashrc_extension"
    if ! cat $HOME/.bashrc | grep "source $extension_path" &>/dev/null; then
        echo -e "\nsource $extension_path" >> $HOME/.bashrc
    fi
} >>"$STDOUT_LOG_PATH" 2>>"$STDERR_LOG_PATH" &
task_output $! "$STDERR_LOG_PATH" "Source bashrc_extension in $HOME/.bashrc"
[[ $? -ne 0 ]] && exit 1

if { which nvim || type nvim; } &>/dev/null
then
    {
        mkdir -p $HOME/.config/nvim
        ln -sf $PWD/init.vim $HOME/.config/nvim
        ln -sf $PWD/init.vim $HOME/.vimrc
    } >>"$STDOUT_LOG_PATH" 2>>"$STDERR_LOG_PATH" &
    task_output $! "$STDERR_LOG_PATH" \
        "Create soft links for '$HOME/.vimrc' and '$HOME/.config/nvim'"
    [[ $? -ne 0 ]] && exit 1

    #
    #  (note) You must run `:PlugInstall` from vim or neovim to install
    #          your tools
    #
    # Install Vim-Plug for adding pluggins to vim and neovim
    if ! [ -f $HOME/.local/share/nvim/site/autoload/plug.vim ]
    then
        mkdir -p $HOME/.local/share/nvim/site/autoload
        {
            curl -Lo $HOME/.local/share/nvim/site/autoload/plug.vim \
                https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            nvim -c "PlugInstall | qall" --headless
        } >>"$STDOUT_LOG_PATH" 2>>"$STDERR_LOG_PATH" &
        task_output $! "$STDERR_LOG_PATH" "Download & Install vim-plug"
        [[ $? -ne 0 ]] && exit 1
    fi
fi

if { which git || type git; } &>/dev/null
then
    {
        git config --global user.name JustScott
        git config --global user.email development@justscott.me
    } >>"$STDOUT_LOG_PATH" 2>>"$STDERR_LOG_PATH" &
    task_output $! "$STDERR_LOG_PATH" "Configure global git user defaults"
    [[ $? -ne 0 ]] && exit 1
fi

# We can presume X to be running if wayland isnt, and the $DISPLAY variable has value
if [[ -z $WAYLAND_DISPLAY && $DISPLAY ]]
then
    ln -sf $PWD/.xinitrc $HOME/.xinitrc >>"$STDOUT_LOG_PATH" 2>>"$STDERR_LOG_PATH" &
    task_output $! "$STDERR_LOG_PATH" "Create soft link to $HOME/.xinitrc"
    [[ $? -ne 0 ]] && exit 1
fi

if { which river || type river; } &>/dev/null
then
    {
        mkdir -p $HOME/.config/river
        ln -sf $PWD/river/init $HOME/.config/river/
    } >>"$STDOUT_LOG_PATH" 2>>"$STDERR_LOG_PATH" &
    task_output $! "$STDERR_LOG_PATH" "Create soft link to '$HOME/.config/river/init'"
    [[ $? -ne 0 ]] && exit 1
fi

if { which foot || type foot; } &>/dev/null
then
    {
        mkdir -p $HOME/.config/foot
        ln -sf $PWD/foot/foot.ini $HOME/.config/foot/
    } >>"$STDOUT_LOG_PATH" 2>>"$STDERR_LOG_PATH" &
    task_output $! "$STDERR_LOG_PATH" "Create soft link to '$HOME/.config/foot/foot.ini'"
    [[ $? -ne 0 ]] && exit 1
fi

if { which lf || type lf; } &>/dev/null
then
    {
        mkdir -p $HOME/.config/lf
        ln -sf $PWD/lf/{lfrc,previewer.sh} $HOME/.config/lf/
    } >>"$STDOUT_LOG_PATH" 2>>"$STDERR_LOG_PATH" &
    task_output $! "$STDERR_LOG_PATH" "Create soft link to '$HOME/.config/lf/{lfrc,previewer.sh}'"
    [[ $? -ne 0 ]] && exit 1
fi

if { which lynx || type lynx; } &>/dev/null
then
    {
        mkdir -p $HOME/.config/lynx
        ln -sf $PWD/lynx/lynx.cfg $HOME/.config/lynx/
    } >>"$STDOUT_LOG_PATH" 2>>"$STDERR_LOG_PATH" &
    task_output $! "$STDERR_LOG_PATH" "Create soft link to '$HOME/.config/lynx/lynx.cfg'"
    [[ $? -ne 0 ]] && exit 1
fi

if { which calcurse || type calcurse; } &>/dev/null
then
    {
        mkdir -p $HOME/.config/calcurse
        ln -sf $PWD/calcurse/conf $HOME/.config/calcurse/
    } >>"$STDOUT_LOG_PATH" 2>>"$STDERR_LOG_PATH" &
    task_output $! "$STDERR_LOG_PATH" "Create soft link to '$HOME/.config/calcurse/conf'"
    [[ $? -ne 0 ]] && exit 1
fi

if { which picom || type picom; } &>/dev/null
then
    {
        mkdir -p $HOME/.config/picom
        ln -sf $PWD/picom/picom.conf $HOME/.config/picom
    } >>"$STDOUT_LOG_PATH" 2>>"$STDERR_LOG_PATH" &
    task_output $! "$STDERR_LOG_PATH" "Create soft link to '$HOME/.config/picom/picom.conf'"
    [[ $? -ne 0 ]] && exit 1
fi

if { which bat || type bat; } &>/dev/null
then
    {
        mkdir -p $HOME/.config/bat
        ln -sf $PWD/bat/config $HOME/.config/bat/config
    } >>"$STDOUT_LOG_PATH" 2>>"$STDERR_LOG_PATH" &
    task_output $! "$STDERR_LOG_PATH" "Create soft link to '$HOME/.config/bat/config'"
    [[ $? -ne 0 ]] && exit 1


    if { which git || type git; } &>/dev/null
    then
        git config --global core.pager "bat --paging=always --style=changes" \
            >>"$STDOUT_LOG_PATH" 2>>"$STDERR_LOG_PATH" &
        task_output $! "$STDERR_LOG_PATH" "Configure global git pager as bat"
        [[ $? -ne 0 ]] && exit 1
    fi
fi

if { which newsboat || type newsboat; } &>/dev/null
then
    {
        mkdir -p $HOME/.config/newsboat
        ln -sf $PWD/newsboat/{config,urls} $HOME/.config/newsboat/
    } >>"$STDOUT_LOG_PATH" 2>>"$STDERR_LOG_PATH" &
        task_output $! "$STDERR_LOG_PATH" \
            "Create soft link to '$HOME/.config/newsboat/{config,urls}'"
        [[ $? -ne 0 ]] && exit 1
fi

if { which mpv || type mpv; } &>/dev/null
then
    {
        mkdir -p $HOME/.config/mpv
        ln -sf $PWD/mpv/mpv.conf $HOME/.config/mpv/
    } >>"$STDOUT_LOG_PATH" 2>>"$STDERR_LOG_PATH" &
        task_output $! "$STDERR_LOG_PATH" \
            "Create soft link to '$HOME/.config/mpv/mpv.conf'"
        [[ $? -ne 0 ]] && exit 1
fi

if { which ytfzf || type ytfzf; } &>/dev/null
then
    {
        mkdir -p $HOME/.config/ytfzf
        ln -sf $PWD/ytfzf/conf.sh $HOME/.config/ytfzf/
    } >>"$STDOUT_LOG_PATH" 2>>"$STDERR_LOG_PATH" &
        task_output $! "$STDERR_LOG_PATH" \
            "Create soft link to '$HOME/.config/ytfzf/conf.sh'"
        [[ $? -ne 0 ]] && exit 1
fi

if { which ollama || type ollama; } &>/dev/null
then
    {
        mkdir -p $HOME/.config/ollama/CustomModels
        ln -sf $PWD/ollama/CustomModels/* $HOME/.config/ollama/CustomModels/
    } >>"$STDOUT_LOG_PATH" 2>>"$STDERR_LOG_PATH" &
        task_output $! "$STDERR_LOG_PATH" \
            "Create soft link to '$HOME/.config/ollama/CustomModels'"
        [[ $? -ne 0 ]] && exit 1

    # TODO: Create ollama models with same name as file, display output
    #       for each seperately
fi
