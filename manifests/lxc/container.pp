class lxc-test-box::lxc::container {

  define create () {
    $rootfs = "/var/rootfs/$name"

    file { "$rootfs":
      ensure => directory,
    }

    exec { "yum groupinstall core for $name":
      command => "/usr/bin/yum -y --installroot=$rootfs groupinstall core",
      require => File["/var/rootfs/$name"],
      timeout => 0,
    }

    exec { "install lxc for $name":
      command => "/usr/bin/yum -y --installroot=$rootfs install /tmp/lxc-0.7.5-1.x86_64.rpm",
      require => File['/tmp/lxc-0.7.5-1.x86_64.rpm'],
      timeout => 0,
      unless  => "/bin/rpm -qa --root=$rootfs | grep lxc-0.7.5-1",
    }

    exec { "install lxc-devel for $name":
      command => "/usr/bin/yum -y --installroot=$rootfs install /tmp/lxc-devel-0.7.5-1.x86_64.rpm",
      require => File['/tmp/lxc-devel-0.7.5-1.x86_64.rpm'],
      timeout => 0,
      unless  => "/bin/rpm -qa --root=$rootfs | grep lxc-devel-0.7.5-1",
    }

    exec { "set root password for $name":
      command => "/usr/sbin/chroot $rootfs bash -e -c 'echo root:root | chpasswd'",
      require => Exec["yum groupinstall core for $name"],
    }

    file { "rc.sysinit for $name":
      path    => "$rootfs/etc/rc.d/rc.sysinit",
      source  => "puppet:///modules/lxc-test-box/rc.sysinit",
      require => Exec["yum groupinstall core for $name"],
    }

    file { "fstab for $name":
      path    => "$rootfs/etc/fstab",
      source  => "puppet:///modules/lxc-test-box/fstab",
      require => Exec["yum groupinstall core for $name"],
    }

    file { "resolv.conf for $name":
      path    => "$rootfs/etc/resolv.conf",
      source  => "file:///etc/resolv.conf",
      require => Exec["yum groupinstall core for $name"],
    }

    exec {
      "stop auditd for $name":
        require => Exec["yum groupinstall core for $name"],
        command => "/usr/sbin/chroot $rootfs /sbin/chkconfig auditd off";
      "stop postfix for $name":
        require => Exec["yum groupinstall core for $name"],
        command => "/usr/sbin/chroot $rootfs /sbin/chkconfig postfix off";
      "stop crond for $name":
        require => Exec["yum groupinstall core for $name"],
        command => "/usr/sbin/chroot $rootfs /sbin/chkconfig crond off";
      "stop udev-post for $name":
        require => Exec["yum groupinstall core for $name"],
        command => "/usr/sbin/chroot $rootfs /sbin/chkconfig udev-post off";
    }

  }

}
