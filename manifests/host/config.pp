class lxc_test_box::host::config {
  file { '/var/log/lxc': ensure => directory }

  file {
    '/root/.ssh/insecurekey':
      owner   => 'root',
      group   => 'root',
      mode    => 600,
      source  => 'puppet:///modules/lxc_test_box/insecurekey';
    '/root/.ssh/insecrekey.pub':
      owner   => 'root',
      group   => 'root',
      mode    => 644,
      source  => 'puppet:///modules/lxc_test_box/insecurekey';
    '/root/.ssh/config':
      owner   => 'root',
      group   => 'root',
      mode    => 644,
      source  => 'puppet:///modules/lxc_test_box/ssh-config';
  }

  file {
    '/etc/lxc':
      ensure => directory;
    '/etc/lxc/conf.d':
      ensure  => directory,
      require => File['/etc/lxc'];
  }

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
