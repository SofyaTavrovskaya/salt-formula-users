{% from "users/map.jinja" import users with context %}

{% for user, user_spec in pillar.get('users', {}).items() %}
{% if user_spec.get('present', True) %}
create_{{ user }}:
  user.present:
    - name: {{ user_spec['name'] }}
    - shell: {{ user_spec['shell'] }}
    - home: {{ user_spec['home'] }}
  {% if user_spec.uid is defined %}
    - uid: {{ user_spec['uid'] }}
  {% endif %}
  {% if user_spec.uid is defined %}
    - gid: {{ user_spec['gid'] }}
  {% endif %}
  {% if user_spec.groups is defined %}
    - groups: {{ user_spec['groups'] }}
  {% endif %}

{% if pillar.get('sudouser', True) %}
/etc/sudoers.d/{{ user_spec['name'] }}:
  file.managed:
    - source: salt://users/templates/sudoers.d.jinja2
    - template: jinja
    - context:
        user_name: {{ user_spec['name'] }}
{% endif %}

{% else %}

delete_{{ user }}:
   user.absent:
      - name: {{ user_spec['name'] }}

{% endif %}
{% endfor %}
