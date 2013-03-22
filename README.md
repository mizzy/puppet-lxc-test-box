# puppet-lxc-test-box

Clone two puppet modules.

```
$ git clone git://github.com/mizzy/puppet-lxc-test-box.git lxc-test-box
$ git clone git://github.com/duritong/puppet-sysctl.git sysctl
```

Write a manifest file.

```
include lxc-test-box

Exec { path => '/sbin:/usr/sbin:/bin:/usr/sbin' }

lxc-test-box::lxc::setup { 'base':   ipaddress => '172.16.0.2' }
lxc-tets-box::lxc::setup { 'manage': ipaddress => '172.16.0.3' }
lxc-test-box::lxc::setup { 'smtp':   ipaddress => '172.16.0.4' }
```

Apply this manifest.

```
$ sudo puppet apply --modulepath=. lxc-test-box.pp
```

