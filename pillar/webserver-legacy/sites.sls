#   -------------------------------------------------------------
#   Salt — Sites to provision on the legacy web server
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Project:        Nasqueron
#   License:        Trivial work, not eligible to copyright
#   -------------------------------------------------------------

#   -------------------------------------------------------------
#   Domains we deploy
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

web_domains:
  #
  # Directly managed by Nasqueron
  #
  nasqueron:
    - nasqueron.org
  #
  # Nasqueron members
  #
  nasqueron_members:
    - dereckson.be
  #
  # Wolfplex
  #
  wolfplex:
    - wolfplex.be

#   -------------------------------------------------------------
#   Static sites
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

web_static_sites:
  nasqueron.org:
    - www
    - assets
    - docker
    - ftp
    - trustspace

#   -------------------------------------------------------------
#   PHP sites
#
#   Username must be unique and use max 31 characters.
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

php_fpm_instances:
  # PHP 7.1, generally installed as package/port
  prod:
    command: /usr/local/sbin/php-fpm

web_php_sites:
  www.dereckson.be:
    user: web-be-dereckson-www
    source: wwwroot/dereckson.be/www
    target: /var/wwwroot/dereckson.be/www
    autochmod: True
    php-fpm: prod

#   -------------------------------------------------------------
#   Tweaks
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

web_autochmod:
  - /var/wwwroot/dereckson.be/www
