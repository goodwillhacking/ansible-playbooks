Ansible Vagrant playbook
========================

This role install Vagrant

Requirements
------------

This role requires Ansible 1.4 or higher and platform requirements are listed
in the metadata file.

Role Variables
--------------

The variables that can be passed to this role and a brief description about
them are as follows.

```
# Install minimum version
vagrant_version: "1.7.2"
# Set arch
vagrant_arch: "x86_64"
# Upgrade to the latest version
vagrant_upgrade: False
```

Examples
========

```
# Roles
- name: vagrant
  hosts: vagrant
  user: root
  roles:
    - vagrant
  vars:
    - vagrant_upgrade: True
```

Dependencies
------------

None

License
-------

GPL

Author Information
------------------

Pierre Mavro / deimosfr
