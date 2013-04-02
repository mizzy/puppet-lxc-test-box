class lxc_test_box::host::install {
  package {
    'monit':
      ensure => present;
    'lxc':
      ensure => present;
  }

  file { '/root/.ssh':
    mode   => 700,
    ensure => directory,
    owner  => 'root',
    group  => 'root',
  }
      
}
