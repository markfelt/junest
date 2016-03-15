#!/data/data/com.termux/files/usr/bin/env bash
#
# This file is part of JuNest (https://github.com/fsquillace/junest)
#
# Copyright (c) 2015
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU Library General Public License as published
# by the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

function echoerr(){
    echo "$@" 1>&2
}
function die(){
# $@: msg (mandatory) - str: Message to print
    error $@
    exit 1
}
function error(){
# $@: msg (mandatory) - str: Message to print
    echoerr -e "\033[1;31m$@\033[0m"
}
function warn(){
# $@: msg (mandatory) - str: Message to print
    echoerr -e "\033[1;33m$@\033[0m"
}
function info(){
# $@: msg (mandatory) - str: Message to print
    echo -e "\033[1;37m$@\033[0m"
}

function ask(){
    # $1: question string
    # $2: default value - can be either Y, y, N, n (by default Y)

    local default="Y"
    [ -z $2 ] || default=$(echo "$2" | tr '[:lower:]' '[:upper:]')

    local other="n"
    [ "$default" == "N" ] && other="y"

    local prompt="$1 (${default}/${other})> "

    local res="none"
    while [ "$res" != "Y" ] && [ "$res" != "N"  ] && [ "$res" != "" ];
    do
        read -p "$prompt" res
        res=$(echo "$res" | tr '[:lower:]' '[:upper:]')
    done

    [ "$res" == "" ] && res="$default"

    if [ "$res" == "Y" ]
    then
        return 0
    else
        return 1
    fi

}

function insert_quotes_on_spaces(){
# It inserts quotes between arguments.
# Useful to preserve quotes on command
# to be used inside sh -c/bash -c
    C=''
    whitespace="[[:space:]]"
    for i in "$@"
    do
        if [[ $i =~ $whitespace ]]
        then
            C="$C \"$i\""
        else
            C="$C $i"
        fi
    done
    echo $C
}

contains_element () {
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  return 1
}
