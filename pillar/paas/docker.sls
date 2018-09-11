#   -------------------------------------------------------------
#   Salt — Provision Docker engine
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Project:        Nasqueron
#   Created:        2018-03-10
#   License:        Trivial work, not eligible to copyright
#   -------------------------------------------------------------

docker_aliases:
  - &ipv4_equatower 51.255.124.10

#   -------------------------------------------------------------
#   Images
#
#   You can append a :tag (by default, latest is used).
#
#   It's not possible to specify Docker library images only by final name.
#   See https://docs.saltstack.com/en/latest/ref/states/all/salt.states.docker_image.html
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

docker_images:
  '*':
    - certbot/certbot
  dwellers:
    # Core services
    - nasqueron/rabbitmq
    # Infrastructure and development services
    - dereckson/cachet
    - nasqueron/notifications
  equatower:
    # Core services
    - nasqueron/mysql
    # Infrastructure and development services
    - nasqueron/aphlict
    - nasqueron/etherpad
    - nasqueron/phabricator
    # Continuous deployment jobs
    - jenkinsci/jenkins
    - nasqueron/jenkins-slave-php
    # phpBB SaaS
    -  nasqueron/mysql

#   -------------------------------------------------------------
#   Containers
#
#   The docker_containers entry allow to declare
#   containers by image by servers
#
#   The hierarchy is so as following.
#
#   docker_containers:
#     server with the Docker engine:
#       service codename:
#         instance name:
#            container properties
#
#   The service codename must match a state file in
#   the roles/paas-docker/containers/ directory.
#
#   The container will be run with the specified instance name.
#
#   **nginx**
#
#   The container properties can also describe the information
#   needed to configure nginx with the host and app_port key.
#
#   In such case, a matching vhost file should be declared as
#   roles/paas-docker/nginx/files/vhosts/<service codename>.sls
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

docker_containers:

  #
  # Equatower is the current production engine
  #
  equatower:

     #
     # Core services
     #

    mysql:
      acquisitariat: {}
      phpbb_db: {}

     #
     # CD
     #

    jenkins:
      jenkins_cd:
        host: cd.nasqueron.org
        app_port: 38080
        jnlp_port: 50000

    jenkins_slave:
      # Slaves for CD
      apsile:
        ip: 172.17.0.100
      elapsi:
        ip: 172.17.0.101

    # Infrastructure and development services

    phabricator:
      devcentral:
        app_port: 31080
        host: devcentral.nasqueron.org
        aliases:
          - phabricator.nasqueron.org
        blogs:
          servers:
            host: servers.nasqueron.org
            aliases:
              - server.nasqueron.org
              - serveur.nasqueron.org
              - serveurs.nasqueron.org
        static_host: phabricator-files-for-devcentral-nasqueron.spacetechnology.net

    aphlict:
      aphlict:
        ports:
          client: 22280
          admin: 22281

    cachet:
      cachet:
        app_port: 39080
        host: status.nasqueron.org
        credential: 47
        mysql_link: acquisitariat

    etherpad:
      pad:
        app_port: 34080
        host: pad.nasqueron.org
        aliases:
          - pad.wolfplex.org
          - pad.wolfplex.be
        mysql_link: acquisitariat
        plugins:
          - ep_ether-o-meter
          - ep_author_neat

    # phpBB SaaS
    # The SaaS uses a MySQL instance, declared in the MySQL section.

    # Openfire
    openfire:
      openfire:
        ip: *ipv4_equatower
        app_port: 9090
        host: xmpp.nasqueron.org

 #   -------------------------------------------------------------
 #   Ports listened by XMPP
 #   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

xmpp_ports:
  - 3478
  - 5222 # Client to server
  - 5223 # Client to server (Encrypted (legacy-mode) connections)
  - 5262 # Connections managers
  - 5269 # Server to server
  - 5275 # External components
  - 5276 # External components (Encrypted (legacy-mode) connections)
  - 7070 # HTTP binding
  - 7443 # HTTP binding with TLS
  - 7777 # File transfer proxy
  - 9090 # Web administration server
  - 9091 # Web administration server with TLS

 #   -------------------------------------------------------------
 #   Zemke-Rhyne clients
 #
 #   This section should list all the Docker engines server
 #   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

zr_clients:
  - key: 2
    allowedConnectionFrom:
      - 172.27.26.49
      - dwellers.nasqueron.drake
      - dwellers.nasqueron.org
    restrictCommand:
    comment: Zemke-Rhyne
  - key: 123
    allowedConnectionFrom:
      - equatower.nasqueron.org
    restrictCommand:
    comment: Zemke-Rhyne
