{% from "users/map.jinja" import users with context %}

{% for user, user_spec in pillar.get('users', {}).items() %}
create_{{ user }}:
  user.present:
    - name: {{ user_spec['name'] }}
{% endfor %}


