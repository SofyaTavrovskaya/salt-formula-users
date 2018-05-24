info: Centos pillar data
redhat:
  user.present:
    - fullname: Redhat
    - shell: /bin/bash
    - home: /home/redhat
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

canonical:
  user.absent

sshkeys:
  ssh_auth.present:
    - user: redhat
    - source: salt://centos.pem
