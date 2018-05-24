{% from "map.jinja" import users with context %}
{% set used_sudo = [] %}

{% for group, args in pillar['groups'].iteritems() %}
{{ group }}:
  group.present:
    - name: {{ group }}
{% if 'gid' in args %}
    - gid: {{ args['gid'] }}
{% endif %}
{% endfor %}

{% for user, args in pillar['users'].iteritems() %}
{{ user }}:
  group.present:
    - gid: {{ args['gid'] }}
  user.present:
    - fullname: {{ args['fullname'] }}
    - home: {{ args['home'] }}
    - shell: {{ args['shell'] }}
    - uid: {{ args['uid'] }}
    - gid: {{ args['gid'] }}
    
{% if 'groups' in args %}
    - groups: {{ args['groups'] }}
{% endif %}
    - require:
      - group: {{ user }}

