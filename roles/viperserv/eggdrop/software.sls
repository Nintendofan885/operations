#   -------------------------------------------------------------
#   Salt — Deploy eggdrop park
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Project:        Nasqueron
#   Created:        2017-11-05
#   License:        Trivial work, not eligible to copyright
#   -------------------------------------------------------------

{% from "map.jinja" import dirs with context %}

#   -------------------------------------------------------------
#   Build eggdrop
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

{% set manpage = dirs.man + "/man1/eggdrop.1.gz" %}

eggdrop_software:
  file.directory:
    - name: /opt/eggdrop
    - user: builder
    - group: deployment
  cmd.run:
    - name: install-eggdrop
    - runas: builder
    - env:
      - DEST: /opt/eggdrop
    - creates: /opt/eggdrop/eggdrop

{{ dirs.bin }}/eggdrop:
  file.symlink:
    - target: /opt/eggdrop/eggdrop
    - require:
      - cmd: eggdrop_software

eggdrop_man:
  cmd.run:
    - name: gzip < /opt/eggdrop/doc/man1/eggdrop.1 > {{ manpage }}
    - creates: {{ manpage }}
    - require:
      - cmd: eggdrop_software

#   -------------------------------------------------------------
#   ViperServ directory
#
#   Bots specific subdirectories are managed in config.sls
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

/srv/viperserv:
  file.directory:
    - user: viperserv
    - group: nasqueron-irc
    - dir_mode: 770

viperserv_scripts:
  git.latest:
    - name: https://devcentral.nasqueron.org/source/viperserv.git
    - target: /srv/viperserv/scripts
    - update_head: False
    - user: viperserv
    - require:
      - file: /srv/viperserv

{% for eggdir in ['doc', 'help', 'language'] %}
/srv/viperserv/{{ eggdir }}:
  file.symlink:
    - target: /opt/eggdrop/{{ eggdir }}
    - user: viperserv
    - group: nasqueron-irc
    - require:
      - cmd: eggdrop_software
{% endfor %}

/srv/viperserv/lib:
  file.directory:
    - user: viperserv
    - group: nasqueron-irc
    - dir_mode: 770

/srv/viperserv/logs:
  file.directory:
    - user: viperserv
    - group: nasqueron-irc
    - dir_mode: 770

/srv/viperserv/filesys/incoming:
  file.directory:
    - user: viperserv
    - group: nasqueron-irc
    - makedirs: True
    - dir_mode: 770
