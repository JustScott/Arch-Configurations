#
# ~/.bashrc
#
#
# .bashrc - part of the Arch-Configurations project
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

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export EDITOR=nvim

# For docker
export DOCKER_BUILDKIT=1 #
export COMPOSE_DOCKER_CLI_BUILD=1

alias batt='cat /sys/class/power_supply/BAT0/capacity'
alias admin='su administrator -P -c'
alias space='df -h /'
alias up='ping speedtest.net -c 4'
alias swapc='su - administrator -P -c "sudo swapoff -a;sleep 2;sudo swapon -a"'

alias dlynx='lynx https://lite.duckduckgo.com -accept_all_cookies -cookie_file=/dev/null'
