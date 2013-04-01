class lxc_test_box::rootfs::config {
  $base_dir = $lxc_test_box::rootfs::base_dir

  file { "rc.sysinit for rootfs":
    path    => "$base_dir/etc/rc.d/rc.sysinit",
    source  => "puppet:///modules/lxc_test_box/rc.sysinit",
    require => Exec["yum groupinstall core for rootfs"],
  }

}
