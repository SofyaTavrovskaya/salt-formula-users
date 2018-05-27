info: Centos pillar data
users:                                                                                                                                                       
  user:
    name: Redhat
    shell: /bin/bash
    home: /home/redhat
    uid: 4000
    gid: 4000
    groups:
      - wheel
      - storage
      - games
    sudouser: True

users_absent:
   user:
     name: Canonical
