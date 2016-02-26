
{% for user in pillar['users'] %}
{{ user }}:
  user.present:
    - password: {{ pillar['users'][user]['password'] }}
    - optional_groups:
      - sudo

/home/{{ user }}/.gitconfig:
  file.managed:
    - user: {{ user }}
    - mode: '0644'
    - contents: |
        [user]
          name = {{ pillar['users'][user]['common_name'] }}
          email = {{ pillar['users'][user]['email'] }}
/home/{{ user }}/.ssh:
  file.directory:
    - user: {{ user }}
    - mode: '0700'

/home/{{ user }}/.ssh/authorized_keys:
  file.managed:
    - user: {{ user }}
    - mode: '0600'
    - contents: |
        {%- for key in pillar['users'][user]['public_key'] %}
        {{ key }}
        {%- endfor %}
{% endfor %}
