class lxc-test-box::lxc::config {

  file {
    '/etc/lxc':
      ensure => directory;
    '/etc/lxc/conf.d':
      ensure  => directory,
      require => File['/etc/lxc'];
  }

  define create( $ipaddress_eth0 = '', $ipaddress_eth1 ) {
    $role = $name
    file { "/etc/lxc/conf.d/$name.conf":
      require  => File['/etc/lxc/conf.d'],
      content  => template('lxc-test-box/lxc.conf'),
    }

    file { "/etc/monit.d/$name.conf":
      require => Package['monit'],
      content => template('lxc-test-box/monit.conf'),
      notify  => Service['monit'],
    }

  }

}
