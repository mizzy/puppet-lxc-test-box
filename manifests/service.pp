class lxc-test-box::service {

  service { 'monit':
    ensure  => running,
    enable  => true,
    require => Package['monit'],
  }

}
