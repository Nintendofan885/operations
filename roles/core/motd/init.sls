#   -------------------------------------------------------------
#   Salt — MOTD
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Project:        Nasqueron
#   Created:        2016-04-10
#   License:        Trivial work, not eligible to copyright
#   -------------------------------------------------------------

motd:
  file.managed:
    {% if grains['os'] == 'Debian' or grains['os'] == 'Ubuntu' %}
    - name: /etc/motd.tail
    {% else %}
    - name: /etc/motd
    {% endif %}
    - source: salt://roles/core/motd/files/{{ grains['id'] }}

# Fixes T858
get_rid_of_scaleway_motd:
  file.absent:
    - name: /etc/update-motd.d/50-scw