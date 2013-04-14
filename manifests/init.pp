class lxc_test_box {
  include lxc_test_box::host
  include lxc_test_box::rootfs
  include lxc_test_box::guest

     Class['lxc_test_box::host']
  -> Class['lxc_test_box::rootfs']
  -> Class['lxc_test_box::guest']
}

class lxc_test_box::host {
  include lxc_test_box::host::yumrepo
  include lxc_test_box::host::install
  include lxc_test_box::host::config
  include lxc_test_box::host::service
  include lxc_test_box::host::network

     Class['lxc_test_box::host::yumrepo']
  -> Class['lxc_test_box::host::install']
  -> Class['lxc_test_box::host::config']
  -> Class['lxc_test_box::host::service']
  -> Class['lxc_test_box::host::network']
}

class lxc_test_box::rootfs {
  $base_dir = '/var/rootfs/sl6'

  include lxc_test_box::rootfs::base
  include lxc_test_box::rootfs::install
  include lxc_test_box::rootfs::config
  include lxc_test_box::rootfs::device
  include lxc_test_box::rootfs::service
  include lxc_test_box::rootfs::cleanup
  
     Class['lxc_test_box::rootfs::base']
  -> Class['lxc_test_box::rootfs::install']
  -> Class['lxc_test_box::rootfs::config']
  -> Class['lxc_test_box::rootfs::device']
  -> Class['lxc_test_box::rootfs::service']
  -> Class['lxc_test_box::rootfs::cleanup']

}

class lxc_test_box::guest {
  define setup ( $ipaddress_eth0, $ipaddress_eth1 ) {
    $role = $name
    host { "$name.lxc-test-box": ip => $ipaddress_eth0 }
    rootfs::clone  { $role: }
    rootfs::config { $role: require => Rootfs::Clone[$role] }
    config::create { $role:
      ipaddress_eth0 => $ipaddress_eth0,
      ipaddress_eth1 => $ipaddress_eth1,
      require        => Rootfs::Config[$role],
      notify         => Service['monit'],
    }

       Host["$name.lxc-test-box"]
    -> Rootfs::Clone[$role]
    -> Rootfs::Config[$role]
    -> Config::Create[$role]
  }
}
