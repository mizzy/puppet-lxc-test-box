class lxc_test_box::guest::rootfs {

  define clone {
    $role     = $name
    $base_dir = $lxc_test_box::rootfs::base_dir
    $role_dir = "/var/rootfs/$role"

    exec { "clone rootfs for $role":
      path    => '/bin:/usr/bin',
      command => "mkdir $role_dir; cd $base_dir; tar -cpvf - . |( cd $role_dir; tar xpf - )",
      unless => "/usr/bin/test -d $role_dir",
    }
  }

  define config {
    file { "/var/rootfs/$name/etc":
      ensure => directory,
    }

    file { "/var/rootfs/$name/etc/sysconfig":
      ensure  => directory,
      require => File["/var/rootfs/$name/etc"],
    }

    file { "/etc/sysconfig/network for $name":
      path    => "/var/rootfs/$name/etc/sysconfig/network",
      content => template('lxc_test_box/network'),
      require => File["/var/rootfs/$name/etc/sysconfig"],
    }
  }


}
