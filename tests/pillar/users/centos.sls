{% from "users/centos.yml" import users with context %}

redhat:
  user.present:
    - name: {{ salt['pillar.get']('user:name') }}
    - shell: {{ salt['pillar.get']('user:shell') }}
    - home: {{ salt['pillar.get']('user:home') }}
    - uid: {{ salt['pillar.get']('user:uid') }}
    - gid:{{ salt['pillar.get']('user:gid') }}

{% for group in pillar.get('groups', []) %}
  user_{{ salt['pillar.get']('user:name') }}:
    group.present:
      - name: {{ salt['pillar.get']('user:group') }}
{% endfor %}

{% if pillar.get('sudouser', True) %}
/etc/sudoers.d/redhat:
  file.managed:
    - source: salt://users/templates/sudoers.d.jinja2
    - template: jinja
    - context:
        user_name: {{ salt['pillar.get']('user:name') }}
{% endif %}

canonical:
  user.absent:
    - name: {{ salt['pillar.get']('user:name') }}



