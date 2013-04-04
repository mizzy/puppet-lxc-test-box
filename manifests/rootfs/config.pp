class lxc_test_box::rootfs::config {
  $base_dir = $lxc_test_box::rootfs::base_dir

  exec { "set root password for rootfs":
    command => "/usr/sbin/chroot $base_dir bash -e -c 'echo root:root | chpasswd'",
  }

  file { "rc.sysinit for rootfs":
    path    => "$base_dir/etc/rc.d/rc.sysinit",
    source  => "puppet:///modules/lxc_test_box/rc.sysinit",
  }

  file { "fstab for rootfs":
    path    => "$base_dir/etc/fstab",
    source  => "puppet:///modules/lxc_test_box/fstab",
  }

  file { "resolv.conf for rootfs":
    path    => "$base_dir/etc/resolv.conf",
    source  => "file:///etc/resolv.conf",
  }


  file { "/etc/sysconfig/static-routes for rootfs":
    path    => "$base_dir/etc/sysconfig/static-routes",
    source  => 'puppet:///modules/lxc_test_box/static-routes',
  }

  file {
    "$base_dir/root/.ssh":
      ensure  => directory;
    "$base_dir/root/.ssh/authorized_keys":
      require => File["$base_dir/root/.ssh"],
      mode    => 644,
      owner   => 'root',
      group   => 'root',
      source  => "puppet:///modules/lxc_test_box/insecurekey.pub";
  }

}
