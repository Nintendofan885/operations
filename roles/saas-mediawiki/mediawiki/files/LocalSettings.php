<?php

#   -------------------------------------------------------------
#   Salt — MediaWiki farm
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Project:        Nasqueron
#   Created:        2018-03-17
#   Description:    Calls saas-mediawiki configuration directory
#   License:        Trivial work, not eligible to copyright
#   Source file:    roles/saas-mediawiki/mediawiki/init.sls
#   -------------------------------------------------------------
#
#   <auto-generated>
#       This file is managed by our rOPS SaltStack repository.
#
#       Changes to this file may cause incorrect behavior
#       and will be lost if the state is redeployed.
#   </auto-generated>

require '{{ directory }}/LocalSettings.php';
