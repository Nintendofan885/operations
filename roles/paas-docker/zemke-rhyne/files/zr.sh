#!/bin/sh

#   -------------------------------------------------------------
#   PaaS Docker
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Project:        Nasqueron
#   Created:        2018-09-08
#   License:        Trivial work, not eligible to copyright
#   Source file:    roles/paas-docker/zemke-rhyne/files/zr.sh
#   -------------------------------------------------------------
#
#   <auto-generated>
#       This file is managed by our rOPS SaltStack repository.
#
#       Changes to this file may cause incorrect behavior
#       and will be lost if the state is redeployed.
#   </auto-generated>

ZR_SERVER="${ZR_SERVER:-ysul.nasqueron.org}"

if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <command name> [options...]" 1>&2;
    exit 1
fi

ssh -4 -i /etc/zr/id_zr "zr@$ZR_SERVER" "$@"
