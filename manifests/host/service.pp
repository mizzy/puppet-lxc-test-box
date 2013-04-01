class lxc_test_box::host::service {

  service { 'monit':
    ensure  => running,
    enable  => true,
    require => Package['monit'],
  }

}
