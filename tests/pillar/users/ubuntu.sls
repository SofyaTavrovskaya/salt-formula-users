info: Ubuntu pillar data
canonical:
  user.present:
    - fullname: Canonical
    - shell: /bin/bash
    - home: /home/canonical
    - uid: 4000
    - gid: 4000
    - groups:
      - wheel
      - storage
      - games
  sudouser: True
  sudo_rules:
      - ALL=(root) /usr/bin/find
      - ALL=(otheruser) /usr/bin/script.sh
  sudo_defaults:
      - '!requiretty'

redhat:
  user.absent

sshkeys:
  ssh_auth.present:
    - user: canonical
    - source: salt://ubuntu.pem
