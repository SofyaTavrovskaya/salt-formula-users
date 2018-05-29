users: 
  redhat: 
     name: redhat
     full_name: redhat
     home: /home/redhat
     shell: /bin/bash
     uid: 4000
     gid: 4000
     groups:
       - wheel
       - storage
     sudouser: True
     user_absent: canonical
  canonical:
     name: canonical
     full_name: My User
     home: /home/myuser
     shell: /bin/bash
     uid: 4000
     gid: 4000
     groups:
       - games
     sudouser: True
     user_absent: redhat

     

