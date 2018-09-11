#   -------------------------------------------------------------
#   Salt — Provision Docker engine
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Project:        Nasqueron
#   Created:        2018-03-16
#   License:        Trivial work, not eligible to copyright
#   -------------------------------------------------------------

{% from "map.jinja" import dirs with context %}
{% set containers = salt['pillar.get']('docker_containers:' + grains['id'], {}) %}

#   -------------------------------------------------------------
#   includes folder
#
#    :: general configuration
#    :: application-specific code
#   -------------------------------------------------------------

{{ dirs.etc }}/nginx/includes:
  file.recurse:
    - source: salt://roles/paas-docker/nginx/files/includes
    - dir_mode: 755
    - file_mode: 644

#   -------------------------------------------------------------
#   vhosts folder
#   -------------------------------------------------------------

{% for service, instances in containers.items() %}
{% for instance, container in instances.items() %}
{% if 'host' in container %}

{{ dirs.etc }}/nginx/vhosts/{{ service }}/{{ instance }}.conf:
  file.managed:
    - source: salt://roles/paas-docker/nginx/files/vhosts/{{ service }}.conf
    - makedirs: True
    - mode: 644
    - template: jinja
    - context:
        fqdn: {{ container['host'] }}
        app_port: {{ container['app_port'] }}
        {% if 'aliases' in container %}
        aliases: {{ container['aliases']|join(" ") }}
        {% endif %}

{% endif %}
{% endfor %}
{% endfor %}
