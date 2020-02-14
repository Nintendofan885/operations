#   -------------------------------------------------------------
#   Salt — Provision Docker engine
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Project:        Nasqueron
#   Created:        2018-09-13
#   License:        Trivial work, not eligible to copyright
#   -------------------------------------------------------------

{% from "map.jinja" import dirs with context %}

include:
  - .kernel
  - .salt
  - .docker
  - .zemke-rhyne
{% if salt['file.file_exists'](dirs['bin'] + '/zr') %}
  - .containers
{% endif %}
  - .systemd-unit
  - .wwwroot-502
  - .nginx
  - .letsencrypt
  - .wrappers
