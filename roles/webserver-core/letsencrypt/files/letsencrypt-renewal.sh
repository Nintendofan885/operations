#!/bin/sh

#   -------------------------------------------------------------
#   Let's encrypt
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Project:        Nasqueron
#   Created:        2016-08-24
#   License:        Trivial work, not eligible to copyright
#   Source file:    roles/webserver-core/letsencrypt/files/letsencrypt-renewal.sh
#   -------------------------------------------------------------
#
#   <auto-generated>
#       This file is managed by our rOPS SaltStack repository.
#
#       Changes to this file may cause incorrect behavior
#       and will be lost if the state is redeployed.
#   </auto-generated>

nginx_test() {
	nginx_output="$(nginx -t 2>&1)"
	nginx_returncode="$?"

	if [ "$nginx_returncode" -eq 0 ] && [ -n "$(echo "${nginx_output}" | grep warn)" ]; then
		return 2;
	else
		return "$nginx_returncode";
	fi;
}


certbot renew && nginx_test && service nginx restart
