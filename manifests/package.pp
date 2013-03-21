class lxc-test-box::package {

  package { 'monit': ensure => present }

  file {
    '/tmp/lxc-0.7.5-1.x86_64.rpm':
      source => 'puppet:///modules/lxc-test-box/lxc-0.7.5-1.x86_64.rpm';
    '/tmp/lxc-devel-0.7.5-1.x86_64.rpm':
      source => 'puppet:///modules/lxc-test-box/lxc-devel-0.7.5-1.x86_64.rpm';
  }

    exec { "install lxc":
      command => "/usr/bin/yum -y install /tmp/lxc-0.7.5-1.x86_64.rpm",
      require => File['/tmp/lxc-0.7.5-1.x86_64.rpm'],
      timeout => 0,
      unless  => "/bin/rpm -qa | grep lxc-0.7.5-1",
    }

    exec { "install lxc-devel":
      command => "/usr/bin/yum -y install /tmp/lxc-devel-0.7.5-1.x86_64.rpm",
      require => File['/tmp/lxc-devel-0.7.5-1.x86_64.rpm'],
      timeout => 0,
      unless  => "/bin/rpm -qa | grep lxc-devel-0.7.5-1",
    }

}
