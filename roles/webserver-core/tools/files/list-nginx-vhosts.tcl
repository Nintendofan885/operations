#!/usr/bin/env tclsh8.6

#   -------------------------------------------------------------
#   List nginx vhosts configuration files
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Project:        Nasqueron
#   Created:        2017-10-24
#   License:        BSD-2-Clause
#   Source file:    roles/webserver-core/tools/files/list-nginx-vhosts.tcl
#   -------------------------------------------------------------
#
#   <auto-generated>
#       This file is managed by our rOPS SaltStack repository.
#
#       Changes to this file may cause incorrect behavior
#       and will be lost if the state is redeployed.
#   </auto-generated>

#   -------------------------------------------------------------
#   List
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

proc list_nginx_vhosts {} {
    foreach file [get_vhosts_files] {
        puts "    include $file;"
    }
}

proc get_vhosts_files {} {
    lsort [glob [get_vhosts_path]]
}

proc get_vhosts_path {} {
    join [list [get_local_etc] nginx vhosts *.conf] [file separator]
}

#   -------------------------------------------------------------
#   /etc or /usr/local/etc?
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

proc get_local_etc {} {
    if {[is_bsd_os]} {
        return "/usr/local/etc"
    } {
        return "/etc"
    }
}

proc is_bsd_os {} {
    lcontains [exec uname] {FreeBSD OpenBSD NetBSD DragonFly Darwin}
}

proc lcontains {needle haystack} {
    expr [lsearch $haystack $needle] >= 0
}

#   -------------------------------------------------------------
#   Procedural code
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

list_nginx_vhosts
