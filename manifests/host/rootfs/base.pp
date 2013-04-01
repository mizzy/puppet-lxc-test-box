class lxc_test_box::host::rootfs::base {
  $base_dir = $lxc_test_box::host::rootfs::base_dir

  file { "$base_dir":
    ensure => directory,
  }

  exec { "yum groupinstall core for base":
    command => "/usr/bin/yum -y --installroot=$rootfs groupinstall core",
    require => File[$base_dir],
    timeout => 0,
  }


}
