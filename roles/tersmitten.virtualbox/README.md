## virtualbox

[![Build Status](https://travis-ci.org/Oefenweb/ansible-virtualbox.svg?branch=master)](https://travis-ci.org/Oefenweb/ansible-virtualbox) [![Ansible Galaxy](http://img.shields.io/badge/ansible--galaxy-virtualbox-blue.svg)](https://galaxy.ansible.com/list#/roles/4367)

Set up [VirtualBox](https://www.virtualbox.org/) in Debian-like systems.

#### Requirements

None

#### Variables

* `virtualbox_version` [default: `5.0`, `4.3` for `Ubuntu 10.04`]: Version to install
* `virtualbox_install`: [default: `[]`]: Additional packages to install (e.g. `dkms`)

## Dependencies

None

#### Example

```yaml
---
- hosts: all
  roles:
    - virtualbox
```

#### License

MIT

#### Author Information

Mischa ter Smitten

#### Feedback, bug-reports, requests, ...

Are [welcome](https://github.com/Oefenweb/ansible-virtualbox/issues)!