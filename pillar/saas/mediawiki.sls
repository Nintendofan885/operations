#   -------------------------------------------------------------
#   Salt — MediaWiki farm
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Project:        Nasqueron
#   Created:        2018-03-16
#   License:        Trivial work, not eligible to copyright
#   -------------------------------------------------------------

mediawiki_extensions:
  - Cite
  - WikiEditor
  - SyntaxHighlight_GeSHi
  - CodeEditor
  - Scribunto
  - ParserFunctions

mediawiki_skins:
  - MonoBook
  - Timeless
  - Vector

mediawiki_saas:
  directory: /var/51-wwwroot/saas-mediawiki
  mediawiki_directory: /srv/mediawiki
  fastcgi_url: unix:/var/run/web/wikis.nasqueron.org/php-fpm.sock
  db:
    host: 127.0.0.1
    user: mediawiki-saas

mediawiki_datastores:
  ###
  ### Nasqueron
  ###
  - agora.nasqueron.org

  ###
  ### Other wikis hosted on the Nasqueron servers
  ###
  - arsmagica.espace-win.org
  - utopia.espace-win.org
  - www.wolfplex.org