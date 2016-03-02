postfix:
  pkg:
    - installed
  service.running:
    - require:
      - pkg: postfix
      - file: /etc/postfix/main.cf
      # - file: /etc/aliases
    - watch:
      - file: /etc/postfix/main.cf

/etc/postfix/main.cf:
  file.managed:
    - source: salt://mail/postfix/main.cf
    - template: jinja
    - require:
      - pkg: postfix

/etc/aliases:
  file.managed:
    - contents_pillar: mail_aliases
    - require:
      - pkg: postfix

# /etc/postfix/access:
#   file.managed:
#     - contents_pillar: postfix_access
#     - require:
#       - pkg: postfix

# update-access:
#   cmd.wait:
#     - name: postmap /etc/postfix/access
#     - watch:
#       - file: /etc/postfix/access

# update-aliases:
#   cmd.wait:
#     - name: newaliases
#     - watch:
#       - file: /etc/aliases
