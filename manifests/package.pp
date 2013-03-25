class lxc-test-box::package {

  package {
    'monit':
      ensure => present;
    'lxc':
      ensure => present;
  }


}
