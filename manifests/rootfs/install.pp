class lxc_test_box::rootfs::install {
  $base_dir = $lxc_test_box::rootfs::base_dir

  exec { "install lxc for rootfs":
    command => "/usr/bin/yum -y --installroot=$basedir install lxc",
    timeout => 0,
    unless  => "/bin/rpm -qa --root=$basedir | grep lxc",
  }

}
