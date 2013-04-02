# puppet-lxc-test-box

This module works on Red Hat Enterprise or RHEL clone version 6.x.

Clone two puppet modules.

```
$ git clone git://github.com/mizzy/puppet-lxc-test-box.git lxc_test_box
$ git clone git://github.com/duritong/puppet-sysctl.git sysctl
```

Write a manifest file.

```
include lxc_test_box

Exec { path => '/sbin:/usr/sbin:/bin:/usr/bin' }

lxc_test_box::guest::setup { 'base':
  ipaddress_eth0 => '172.16.0.2',
  ipaddress_eth1 => '172.16.1.2',
}

lxc_test_box::guest::setup { 'manage':
  ipaddress_eth0 => '172.16.0.3',
  ipaddress_eth1 => '172.16.1.3',
}
```

Apply this manifest.

```
$ sudo puppet apply --modulepath=. lxc_test_box.pp
```

