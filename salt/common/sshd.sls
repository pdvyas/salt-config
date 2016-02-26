ssh:
  service.running:
    - watch:
      - file: /etc/ssh/sshd_config

/etc/ssh/sshd_config:
  file.replace:
    - pattern: ^\s*PasswordAuthentication\s*yes
    - repl: PasswordAuthentication no
    - append_if_not_found: True
