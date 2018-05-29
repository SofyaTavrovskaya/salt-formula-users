include:
{% if pillar.users.ubuntu is defined %}
- ubuntu.users
{% endif %}

{% if pillar.users.centos is defined %}
- centos.users
{% endif %}
