users:                                                                                                                                                       
  user:
    name: Canonical
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
     name: Radhat
