#   -------------------------------------------------------------
#   Salt — Provision IRC software
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Project:        Eglide
#   Created:        2016-04-09
#   License:        Trivial work, not eligible to copyright
#   -------------------------------------------------------------

#   -------------------------------------------------------------
#   IRC clients
#   -------------------------------------------------------------

irc_clients:
  pkg:
    - installed
    - pkgs:
      - irssi
      - irssi-scripts
      - weechat
      {% if grains['os'] != 'Debian' and grains['os'] != 'Ubuntu' %}
      # Reference: supremetechs.com/tag/bitchx-removed-from-debian
      - bitchx
      {% endif %}

#   -------------------------------------------------------------
#   Bouncers
#   -------------------------------------------------------------

irc_bouncers:
  pkg:
    - installed
    - pkgs:
      - znc

#   -------------------------------------------------------------
#   Bots
#   -------------------------------------------------------------

eggdrop_installer:
  file.managed:
    - name: /usr/local/bin/install-eggdrop
    - source: salt://roles/shellserver/userland-software/files/install-eggdrop
    - mode: 755

#   -------------------------------------------------------------
#   Misc
#   -------------------------------------------------------------

irc_misc:
  pkg:
    - installed
    - pkgs:
      - bitlbee
      - pisg
