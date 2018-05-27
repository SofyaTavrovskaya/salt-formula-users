{% from "map.jinja" import users with context %}

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

{% if user.get('sudo', true) %}
/etc/sudoers.d/{{ user.fullname }}:
  file.managed:
    - source: salt://users/templates/sudoers.d.jinja
    - template: jinja
    - context:
        user_name: {{ user.fullname }}
{% endif -%}



