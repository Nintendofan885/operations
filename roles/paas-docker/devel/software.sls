#   -------------------------------------------------------------
#   Salt — Docker development tools
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Project:        Nasqueron
#   Created:        2020-02-15
#   License:        Trivial work, not eligible to copyright
#   -------------------------------------------------------------

{% from "map.jinja" import packages_prefixes with context %}

#   -------------------------------------------------------------
#   Dependencies not required in production but useful in dev
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

docker_development_utilities:
  pkg.installed:
    - pkgs:
      - git
      - {{ packages_prefixes.python3 }}pip
      # From Nasqueron repo
      - dive
  pip.installed:
    - name: docker-compose
    - require:
      - pkg: docker_development_utilities