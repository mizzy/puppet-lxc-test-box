class lxc-test-box::cgroup {

  file { '/cgroup':
    ensure => directory,
  }

  mount { '/cgroup':
    atboot  => true,
    ensure  => mounted,
    fstype  => 'cgroup',
    device  => 'none',
    options => 'defaults',
    require => File['/cgroup'],
  }

}
