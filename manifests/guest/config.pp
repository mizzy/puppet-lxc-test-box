class lxc_test_box::guest::config {
  define create( $ipaddress_eth0, $ipaddress_eth1 ) {
    $role = $name
    file { "/etc/lxc/conf.d/$role.conf":
      require  => File['/etc/lxc/conf.d'],
      content  => template('lxc_test_box/lxc.conf'),
    }

    file { "/etc/monit.d/$role.conf":
      require => Package['monit'],
      content => template('lxc_test_box/monit.conf'),
    }
    
  }
}
