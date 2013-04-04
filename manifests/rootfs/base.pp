class lxc_test_box::rootfs::base {
  $base_dir = $lxc_test_box::rootfs::base_dir

  file {
    '/var/rootfs':
      ensure => directory;
    $base_dir:
      ensure => directory,
      require => File['/var/rootfs'];
  }

  exec { "yum groupinstall core for rootfs":
    command => "/usr/bin/yum -y --installroot=$base_dir groupinstall core",
    timeout => 0,
    require => File[$base_dir],
  }

  file { "/etc/yum.repos.d/rpmforge.repo for rootfs":
    path    => "$base_dir/etc/yum.repos.d/rpmforge.repo",
    source  => "puppet:///modules/lxc_test_box/rpmforge.repo",
    require => Exec["yum groupinstall core for rootfs"],
  }

  file { "epel.repo for rootfs":
    path    => "$base_dir/etc/yum.repos.d/epel.repo",
    source  => "puppet:///modules/lxc_test_box/epel.repo",
    require => Exec["yum groupinstall core for rootfs"],
  }

}
