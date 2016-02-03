gizmo
=====

Gizmo is an implementation of a toy-like configuration management tool that demonstrates principles of [desired-state-configuration]() and [idempotency](https://en.wikipedia.org/wiki/Idempotence)


Usage
-----
```
gizmo.rb -h foo -u root -p foobarbaz deploy_web.json
```

Modules
-------

### package

Manages packages (using `apt`)

Options:
```
  state: install, uninstall
  name: name of the package to configure
```

### service

Manages services (using `systemd`)

Options:
```
  state: start, stop, restart, reload, enable, disable
  name: name of the service to configure
```

### users

Manages users (using `useradd`, `usermod`, and `userdel`)

Options:
```
  state: present, absent
  name: name of the service to configure
```

### file

Manage files

Options:
```
  group: group to own file(s)
  user: user to own file(s)
  permissions: permissions for file(s)
  files: array of files
    state: absent, sync
    file: path of file to manage on target
    source: path of file to use as source on controller
```


TODO
----

 - [ ] File templates
