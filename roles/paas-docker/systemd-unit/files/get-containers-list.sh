#!/usr/bin/env bash

#   -------------------------------------------------------------
#   PaaS Docker
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Project:        Nasqueron
#   Created:        2017-01-30
#   License:        Trivial work, not eligible to copyright
#   Source file:    roles/paas-docker/systemd-unit/files/get-containers-list.sh
#   -------------------------------------------------------------
#
#   <auto-generated>
#       This file is managed by our rOPS SaltStack repository.
#
#       Changes to this file may cause incorrect behavior
#       and will be lost if the state is redeployed.
#   </auto-generated>

## Read /etc/containers.conf and recover docker’s names into an array.
## get-containers-list [--reverse]

file='/etc/containers.conf'

if [[ ! -f "$file" ]]; then
    echo "$file : does not exists "
    exit 1
elif [[ ! -r "$file" ]]; then
    echo "$file : can not read "
fi

# Get names in an array
# 21:42 <geirha> since bash 4, you can use mapfile instead of that while read loop. mapfile -t array < "$file"
mapfile -t array < "$file"

# Test argument to know in wich order return names
if [[ $1 == "--reverse" ]]; then
    for ((i="${#array[*]}"; i > 0; i--)); do
        echo "${array[i]}"
    done
elif [[ -z "$1" ]]; then
    for ((i=0; i < "${#array[*]}"; i++)); do
         echo "${array[i]}"
    done
else
    echo "$1 is not a valid argument"
fi
