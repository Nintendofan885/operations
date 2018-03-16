#!/bin/sh

#   -------------------------------------------------------------
#   PaaS Docker
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Project:        Nasqueron
#   Created:        2018-03-15
#   License:        Trivial work, not eligible to copyright
#   Source file:    roles/paas-docker/wrappers/files/certbot.sh
#   -------------------------------------------------------------
#
#   <auto-generated>
#       This file is managed by our rOPS SaltStack repository.
#
#       Changes to this file may cause incorrect behavior
#       and will be lost if the state is redeployed.
#   </auto-generated>

docker run -it --rm \
	-v /srv/letsencrypt/etc:/etc/letsencrypt \
	-v /srv/letsencrypt/var:/var/lib/letsencrypt \
	-v /srv/letsencrypt/www:/www \
	certbot/certbot:latest "$@"
