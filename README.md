Formula allows to set up users on minions

It supports creating and removal of user:

State ``users_absent`` has ``name`` as argument and delete user on the minion

State ``user`` creates user and has such arguments:

* ``name``, ``shell``, ``home`` - strings defining username, shell and home catalog   

* ``uid``, ``gid`` -  integer-typed numbers of user and group IDs

* ``groups`` - list of groups to add user to them

* ``ssh-auth`` - list of plain-text SSH public keys for user

* ``ssh_prv_key`` - list of private key files to install for newly created user

* ``ssh-keys`` - filename-content  key-value pairs which are imported as-is to files in ~/.ssh 
 
* ``sudouser`` - True/False value if user should have sudo ability


State example:
=========================
    #ubuntu.yml

     users:
        user:    
         name: canonical
         shell: /bin/bash
         home: /home/canonical
         uid: 4000
         gid: 4000
         groups:
           - wheel
           - storage
           - games
         sudouser: True
         ssh_auth:
           - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCtyp5d65jnZvN4dozjO1y/cA2Wmrg/hUeXtqeEh5RKPkA10ucWO6q5zIu6pAjB9zwYQYC1rgXs79ieetiBcUYiwMV3RcsociwJSofjP0KlgIeIfFBr+RJjIvpT6jkFKBAavnfgQlr/rReMGUL04EtYAA/rFIhyQBQsNCtItmhReVAmzD3xI3+5QupbOjO1UuK1lukl7CvbsI6FC1POpKDUkFJAy78waZXT/kCnYF1r71L4L2zHfns5r86/y5rzFLJxBIZ8iAzdRxUMps249s4KfT3pyDnXGazPWWuRjUN66wfclkZjoqN8j7rb4hSQAi0SDEoG7t9oL9gOJEmv2qBl root@adm
         ssh_prv_key: salt://salt-formula-users/tests/ubuntu.pem
         ssh_keys:
            key_name: test_key_value
             key_name.pub: test_key_value

      users_absent:
        user:
          name: redhat    

