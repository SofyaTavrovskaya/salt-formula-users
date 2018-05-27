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

{% if user/get('sudo', false) %}
/etc/sudoers.d/{{ user.name }}:
  file.managed:
    - source: salt://users/templates/sudoers.d.jinja
    - template: jinja
    - context:
        user_name: {{ user.name }}
{% endif -%}

{% if 'ssh_keys' in data or 'ssh_key_folder' in data or 'ssh_auth' in data %}
{{ user }}_keydir:
  file.directory:
    - name: {{ homedir }}/.ssh
    - user: {{ user }}
    - group: {{ user_group }}
    - dir_mode: 0700
    - makedirs: True
    - require:
      - user: {{ user }}
      - group: {{ user_group }}
{% endif %}

{% if 'ssh_prv_key' in data %}
{{ user }}_prv_key_{{ ssh_prv_key }}:
  file.managed:
    - name: {{ homedir }}/.ssh/key.pem
    - source: {{ ssh_prv_key }}
    - user: {{ user }}
    - group: {{ user_group }}
    - mode: 600
{% endif %}

{% if 'ssh_keys' in data %}
  {% for key_name in data.ssh_keys.keys() %}
{{ user }}_key_{{ key_name }}:
  file.managed:
    - name: {{ homedir }}/.ssh/{{ key_name }}
    - user: {{ user }}
    - group: {{ user_group }}
    {% if key_name.endswith(".pub") %}
    - mode: 644
    {% else %}
    - mode: 600
    {% endif %}
    - show_diff: False
    - contents_pillar: users:{{ user }}:ssh_keys:{{ key_name }}
  {% endfor %}
{% endif %}

{% if 'ssh_auth' in data %}
  {% for auth_key in data['ssh_auth'] %}
ssh_auth_{{ user }}_{{ loop.index0 }}:
  ssh_auth.present:
    - user: {{ user }}
    - name: {{ auth_key }}
  {% endfor %}
{% endif %}
 

