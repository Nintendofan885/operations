#!/bin/sh

#   -------------------------------------------------------------
#   Intall PHP extension
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Project:        Nasqueron
#   Author:         Sébastien Santoro aka Dereckson
#   Created:        2018-03-29
#   License:        BSD-2-Clause
#   Source file:    roles/devserver/userland-software/files/install-php-extension.sh
#   -------------------------------------------------------------

phpize
./configure
make
