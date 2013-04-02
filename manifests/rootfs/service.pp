class lxc_test_box::rootfs::service {
  $base_dir = $lxc_test_box::rootfs::base_dir

  exec {
    "stop auditd for rootfs":
      command => "/usr/sbin/chroot $base_dir /sbin/chkconfig auditd off";
    "stop postfix for rootfs":
      command => "/usr/sbin/chroot $base_dir /sbin/chkconfig postfix off";
    "stop crond for rootfs":
      command => "/usr/sbin/chroot $base_dir /sbin/chkconfig crond off";
    "stop udev-post for rootfs":
        command => "/usr/sbin/chroot $base_dir /sbin/chkconfig udev-post off";
    }

}
