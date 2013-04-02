class lxc_test_box::host::network {
  file { '/etc/sysconfig/network-scripts/ifcfg-br0':
    source => 'puppet:///modules/lxc_test_box/ifcfg-br0',
    notify => Exec['restart br0'],
  }

  exec {'restart br0':
    command     => '/sbin/ifdown br0; /sbin/ifup br0',
    refreshonly => true,
  }

  file { '/etc/sysconfig/network-scripts/ifcfg-br1':
    source => 'puppet:///modules/lxc_test_box/ifcfg-br1',
    notify => Exec['restart br1'],
  }

  exec {'restart br1':
    command     => '/sbin/ifdown br0; /sbin/ifup br1',
    refreshonly => true,
  }
  sysctl::value { 'net.ipv4.ip_forward': value => 1 }

  file { '/etc/sysconfig/iptables':
    source => 'puppet:///modules/lxc_test_box/iptables',
  }

  service { 'iptables':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/sysconfig/iptables'],
  }
}
