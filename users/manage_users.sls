{% from "users/map.jinja" import users with context %}

{% for user, user_spec in pillar.get('users', {}).items() %}
create_{{ user }}:
  user.present:
    - name: {{ user_spec['name'] }}
    - shell: {{ user_spec['shell'] }}
    - home: {{ user_spec['home'] }}
    - uid: {{ user_spec['uid'] }}
    - gid: {{ user_spec['gid'] }}
    - groups: {{ user_spec['groups'] }}

{% if pillar.get('sudouser', True) %}
/etc/sudoers.d/{{ user_spec['name'] }}:
  file.managed:
    - source: salt://users/templates/sudoers.d.jinja2
    - template: jinja
    - context:
        user_name: {{ user_spec['name'] }}
{% endif %}

delete_{{ user_spec['user_absent'] }}:
  user.absent:
    - name: {{ user_spec['user_absent'] }}

{% endfor %}


