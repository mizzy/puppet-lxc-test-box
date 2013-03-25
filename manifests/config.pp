class lxc-test-box::config {

  file { '/var/log/lxc': ensure => directory }

  file {
    '/root/.ssh':
      mode   => 700,
      ensure => directory;
    '/root/.ssh/insecurekey':
      source  => 'puppet:///modules/lxc-test-box/insecurekey',
      require => File['/root/.ssh'],
      mode    => 600;
    '/root/.ssh/insecrekey.pub':
      source  => 'puppet:///modules/lxc-test-box/insecurekey',
      require => File['/root/.ssh'],
      mode    => 644;
    '/root/.ssh/config':
      require => File['/root/.ssh'],
      owner   => 'root',
      group   => 'root',
      mode    => 644,
      source  => 'puppet:///modules/lxc-test-box/ssh-config';
  }


}
