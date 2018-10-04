#   -------------------------------------------------------------
#   Salt — Provision docs.nasqueron.org website
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Project:        Nasqueron
#   License:        Trivial work, not eligible to copyright
#   -------------------------------------------------------------

{% if salt['node.has_web_content'](".org/nasqueron/docs") %}

{% from "map.jinja" import packages with context %}

#   -------------------------------------------------------------
#   Base directory
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

/var/wwwroot/nasqueron.org/docs:
  file.directory:
    - user: deploy
    - group: web
    - dir_mode: 755

#   -------------------------------------------------------------
#   Deploy a rSW docs dir HTML build to docs.n.o/salt-wrapper
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

/var/wwwroot/nasqueron.org/docs/salt-wrapper:
  file.directory:
    - user: deploy
    - group: web
    - dir_mode: 755

salt_wrapper_doc_build:
  cmd.script:
    - source: salt://roles/webserver-legacy/org/nasqueron/files/build-docs-salt-wrapper.sh
    - args: /var/wwwroot/nasqueron.org/docs/salt-wrapper
    - cwd: /tmp
    - runas: deploy
    - require:
      - file: /var/wwwroot/nasqueron.org/docs/salt-wrapper
      - pkg: sphinx

#   -------------------------------------------------------------
#   Deploy a rLF docs dir HTML build to docs.n.o/limiting-factor
#
#   Job: https://cd.nasqueron.org/job/limiting-factor-doc/
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

/var/wwwroot/nasqueron.org/docs/limiting-factor/rust:
  file.directory:
    - user: deploy
    - group: web
    - dir_mode: 755
    - makedirs: True

limiting_factor_doc_build:
  module.run:
    - name: jenkins.build_job
    - m_name: limiting-factor-doc

#   -------------------------------------------------------------
#   Software to build the docs
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

sphinx:
  pkg.installed:
    - name: {{ packages.sphinx }}

{% endif %}
