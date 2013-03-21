class lxc-test-box::lxc::devices {

  define create() {
    $rootfs = "/var/rootfs/$name"

    file { "/dev/shm for $name":
      path    => "$rootfs/dev/shm",
      ensure  => directory,
      mode    => 1777,
      require => File[$rootfs],
    }

    file { "/dev/pts for $name":
      path    => "$rootfs/dev/pts",
      ensure  => directory,
      mode    => 0755,
      require => File[$rootfs],
    }

    exec {"create $rootfs/dev/null":
      command => "/bin/rm $rootfs/dev/null; /bin/mknod -m 666 $rootfs/dev/null c 1 3",
      unless  => "/usr/bin/file $rootfs/dev/null | /bin/grep special",
    }

    mknod { "$rootfs/dev/zero":
      type  => 'c',
      mode  => 666,
      major => 1,
      minor => 5,
    }

    mknod { "$rootfs/dev/tty":
      type  => 'c',
      mode  => 666,
      major => 5,
      minor => 0,
    }

    mknod { "$rootfs/dev/tty0":
      type  => 'c',
      mode  => 620,
      major => 4,
      minor => 0,
    }

    mknod { "$rootfs/dev/tty1":
      type  => 'c',
      mode  => 620,
      major => 4,
      minor => 1,
    }

    mknod { "$rootfs/dev/tty2":
      type  => 'c',
      mode  => 620,
      major => 4,
      minor => 2,
    }

    mknod { "$rootfs/dev/tty3":
      type  => 'c',
      mode  => 620,
      major => 4,
      minor => 3,
    }

    mknod { "$rootfs/dev/tty4":
      type  => 'c',
      mode  => 620,
      major => 4,
      minor => 4,
    }

    mknod { "$rootfs/dev/console":
      type  => 'c',
      mode  => 600,
      major => 5,
      minor => 1,
    }

    mknod { "$rootfs/dev/full":
      type  => 'c',
      mode  => 666,
      major => 1,
      minor => 7,
    }

    mknod { "$rootfs/dev/random":
      type  => 'c',
      mode  => 666,
      major => 1,
      minor => 8,
    }

    mknod { "$rootfs/dev/urandom":
      type  => 'c',
      mode  => 666,
      major => 1,
      minor => 9,
    }

    mknod { "$rootfs/dev/ptmx":
      type  => 'c',
      mode  => 666,
      major => 5,
      minor => 2,
    }

    file {"$rootfs/dev/ptmx":
      ensure => link,
      target => "/dev/pts/ptmx",
    }

    mknod { "$rootfs/dev/initctl":
      type  => 'p',
      mode  => 600,
    }

    file { "$rootfs/dev/fd":
      ensure => link,
      target => "/proc/self/fd",
    }

    file { "$rootfs/dev/stdin":
      ensure => link,
      target => "/proc/self/fd/0",
    }

    file { "$rootfs/dev/stdout":
      ensure => link,
      target => "/proc/self/fd/1",
    }

    file { "$rootfs/dev/stderr":
      ensure => link,
      target => "/proc/self/fd/2",
    }

  }

  define mknod ( $type, $major = '', $minor = '', $mode ) {
    exec { "create $name":
      command   => "/bin/mknod -m $mode $name $type $major $minor",
      unless    => "/usr/bin/test $name",
    }
  }

}
