{% from "users/map.jinja" import users with context %}

{{ salt['pillar.get']('user:name') }}:
  user.present:
    - name: {{ salt['pillar.get']('user:name') }}
    - shell: {{ salt['pillar.get']('user:shell') }}
    - home: {{ salt['pillar.get']('user:home') }}

{% for group in pillar.get('groups', []) %}
  {{ salt['pillar.get']('user:name') }}:
    group.present:
      - name: {{ salt['pillar.get']('user:groups') }}
{% endfor %}

{% if pillar.get('sudouser', true) %}
/etc/sudoers.d/cannonical:
  file.managed:
    - source: salt://users/templates/sudoers.d.jinja2
    - template: jinja
    - context:
        user_name: {{ salt['pillar.get']('user:name') }}
{% endif %}

{{ salt['pillar.get']('users_absent:name') }}:
  user.absent:
    - name: {{ salt['pillar.get']('users_absent:name') }}








