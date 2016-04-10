#   -------------------------------------------------------------
#   Salt — Provision users accounts
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Project:        Eglide
#   Created:        2016-04-08
#   Description:    Adds and revokes user accounts, in the relevant
#                   groups and with their stable SSH keys.
#   License:        Trivial work, not eligible to copyright
#   -------------------------------------------------------------

#   -------------------------------------------------------------
#   Table of contents
#   -------------------------------------------------------------
#
#   :: Disabled accounts
#   :: Active accounts
#   :: Groups
#   :: Managed SSH keys
#
#   -------------------------------------------------------------

#   -------------------------------------------------------------
#   Disabled accounts
#   -------------------------------------------------------------

#   Currently, there is no revoked accounts on Eglide.
#
#   To disable an account, remove it from the active section and
#   add here the following block:
#
#   orkaevash:
#     user.absent

#   -------------------------------------------------------------
#   Active accounts
#   -------------------------------------------------------------

tomjerr:
  user.present:
    - fullname: Tommy Aditya
    - shell: /bin/bash
    - uid: 2001

#   -------------------------------------------------------------
#   Groups
#   -------------------------------------------------------------

shell:
  group.present:
    - system: True
    - gid: 200
    - members:
      - tomjerr
    
#   -------------------------------------------------------------
#   Managed SSH keys
#   -------------------------------------------------------------

sshkeys:
  ssh_auth.present:
    - user: tomjerr
    - source: salt://roles/shellserver/users/files/ssh_keys/tomjerr