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

}
