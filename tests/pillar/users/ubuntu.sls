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

redhat: user.absent

sshkeys:
  ssh_auth.present:
    - user: canonical
    - source: salt://salt-formula-users/tests/ubuntu.pem
    - config: '%h/.ssh/authorized_keys'

