class lxc_test_box::rootfs::install {
  $base_dir = $lxc_test_box::rootfs::base_dir

  exec { "install lxc for rootfs":
    command => "/usr/bin/yum -y --installroot=$base_dir install lxc",
    timeout => 0,
    unless  => "/bin/rpm -qa --root=$base_dir | grep lxc",
  }

  exec { "install puppet for rootfs":
    command => "/usr/bin/yum -y --installroot=$base_dir install puppet",
    timeout => 0,
    unless  => "/bin/rpm -qa --root=$base_dir | grep puppet",
  }

  exec { "install rubygmes for rootfs":
    command => "/usr/bin/yum -y --installroot=$base_dir install rubygems",
    unless  => "/bin/rpm -qa --root=$base_dir | grep rubygems",
    require => Exec["yum groupinstall core for rootfs"],
  }


}
