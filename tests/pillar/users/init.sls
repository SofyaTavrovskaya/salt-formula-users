{% from "users/map.jinja" import users with context %}

user_{{ name }}:
  user.present:
    - name: {{ name }}
    - shell: {{ shell }}
    - home: {{ home }}
    - uid: {{ uid }}
    - gid: {{ gid }}

{% for group in data.get('groups', []) %}
  user_{{ user }}:
    group.present:
      - name: {{ groups }}
{% endfor %}

{% if data.get('sudouser', true) %}
/etc/sudoers.d/cannonical:
  file.managed:
    - source: salt://users/templates/sudoers.d.jinja2
    - template: jinja
    - context:
        user_name: {{ name }}
{% endif %}

user_{{ name }}:
  user.absent:
    - name: {{ name }}

{% if 'ssh_keys' in data or 'ssh_key_folder' in data or 'ssh_auth' in data %}
{{ user }}_keydir:
  file.directory:
    - name: {{ home }}/.ssh
    - user: {{ user }}
    - dir_mode: 0700
    - makedirs: True
    - require:
      - user: {{ user }}
{% endif %}

{% if 'ssh_prv_key' in data %}
{{ user }}_prv_key_{{ ssh_prv_key }}:
  file.managed:
    - name: {{ home }}/.ssh/key.pem
    - source: {{ ssh_prv_key }}
    - user: {{ user }}
    - mode: 600
{% endif %}

{% if 'ssh_keys' in data %}
  {% for key_name in data.ssh_keys.keys() %}
{{ user }}_key_{{ key_name }}:
  file.managed:
    - name: {{ home }}/.ssh/{{ key_name }}
    - user: {{ user }}
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
