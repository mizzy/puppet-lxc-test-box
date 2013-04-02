class lxc_test_box::rootfs::device {
  $base_dir = $lxc_test_box::rootfs::base_dir

  file { "/dev/shm for rootfs":
    path    => "$base_dir/dev/shm",
    ensure  => directory,
    mode    => 1777,
  }

  file { "/dev/pts for rootfs":
    path    => "$base_dir/dev/pts",
    ensure  => directory,
    mode    => 0755,
  }

  exec {"create $base_dir/dev/null":
    command => "/bin/rm $base_dir/dev/null; /bin/mknod -m 666 $base_dir/dev/null c 1 3",
    unless  => "/usr/bin/file $base_dir/dev/null | /bin/grep special",
  }

  mknod { "$base_dir/dev/zero":
    type  => 'c',
    mode  => 666,
    major => 1,
    minor => 5,
  }

  mknod { "$base_dir/dev/tty":
    type  => 'c',
    mode  => 666,
    major => 5,
    minor => 0,
  }

  mknod { "$base_dir/dev/tty0":
    type  => 'c',
    mode  => 620,
    major => 4,
    minor => 0,
  }

  mknod { "$base_dir/dev/tty1":
    type  => 'c',
    mode  => 620,
    major => 4,
    minor => 1,
  }

  mknod { "$base_dir/dev/tty2":
    type  => 'c',
    mode  => 620,
    major => 4,
    minor => 2,
  }

  mknod { "$base_dir/dev/tty3":
    type  => 'c',
    mode  => 620,
    major => 4,
    minor => 3,
  }

  mknod { "$base_dir/dev/tty4":
    type  => 'c',
    mode  => 620,
    major => 4,
    minor => 4,
  }

  mknod { "$base_dir/dev/console":
    type  => 'c',
    mode  => 600,
    major => 5,
    minor => 1,
  }

  mknod { "$base_dir/dev/full":
    type  => 'c',
    mode  => 666,
    major => 1,
    minor => 7,
  }

  mknod { "$base_dir/dev/random":
    type  => 'c',
    mode  => 666,
    major => 1,
    minor => 8,
  }

  mknod { "$base_dir/dev/urandom":
    type  => 'c',
    mode  => 666,
    major => 1,
    minor => 9,
  }

  mknod { "$base_dir/dev/ptmx":
    type  => 'c',
    mode  => 666,
    major => 5,
    minor => 2,
  }

  file {"$base_dir/dev/ptmx":
    ensure => link,
    target => "/dev/pts/ptmx",
  }

  mknod { "$base_dir/dev/initctl":
    type  => 'p',
    mode  => 600,
  }

  file { "$base_dir/dev/fd":
    ensure => link,
    target => "/proc/self/fd",
  }

  file { "$base_dir/dev/stdin":
    ensure => link,
    target => "/proc/self/fd/0",
  }

  file { "$base_dir/dev/stdout":
    ensure => link,
    target => "/proc/self/fd/1",
  }

  file { "$base_dir/dev/stderr":
    ensure => link,
    target => "/proc/self/fd/2",
  }


  define mknod ( $type, $major = '', $minor = '', $mode ) {
    exec { "create $name":
      command   => "/bin/mknod -m $mode rootfs $type $major $minor",
      unless    => "/usr/bin/test rootfs",
    }
  }


}
