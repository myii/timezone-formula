# -*- coding: utf-8 -*-
# vim: ft=sls

test_getty_udev:
  cmd.run:
    - name: |
        find / -name getty.target
        find / -name "systemd*udev*"
