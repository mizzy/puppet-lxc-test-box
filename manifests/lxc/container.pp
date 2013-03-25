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
      command => "/usr/bin/yum -y --installroot=$rootfs install lxc",
      timeout => 0,
      unless  => "/bin/rpm -qa --root=$rootfs | grep lxc",
    }

    exec { "set root password for $name":
      command => "/usr/sbin/chroot $rootfs bash -e -c 'echo root:root | chpasswd'",
      require => Exec["yum groupinstall core for $name"],
    }


    file { "/etc/yum.repos.d/rpmforge.repo for $name":
      path    => "$rootfs/etc/yum.repos.d/rpmforge.repo",
      source  => "puppet:///modules/lxc-test-box/rpmforge.repo",
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

    file { "epel.repo for $name":
      path    => "$rootfs/etc/yum.repos.d/epel.repo",
      source  => "puppet:///modules/lxc-test-box/epel.repo",
      require => Exec["yum groupinstall core for $name"],
    }


    exec { "yum install rubygmes for $name":
      command => "/usr/bin/yum -y --installroot=$rootfs install rubygems",
      unless  => "/bin/rpm -qa --root=$rootfs | grep rubygems",
      require => Exec["yum groupinstall core for $name"],
    }

    exec { "yum install puppet for $name":
      command => "/usr/bin/yum -y --installroot=$rootfs install puppet",
      unless  => "/bin/rpm -qa --root=$rootfs | grep puppet",
      require => File["epel.repo for $name"],
    }


    file { "/etc/sysconfig/network for $name":
      path    => "$rootfs/etc/sysconfig/network",
      content => template('lxc-test-box/network'),
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

    file {
      "$rootfs/root/.ssh":
        ensure  => directory,
        require => Exec["yum groupinstall core for $name"];
      "$rootfs/root/.ssh/authorized_keys":
        require => File["$rootfs/root/.ssh"],
        mode    => 644,
        owner   => 'root',
        group   => 'root',
        source  => "puppet:///modules/lxc-test-box/insecurekey.pub";
    }

  }

}
