class lxc_test_box {
  include lxc_test_box::host
  include lxc_test_box::rootfs
  include lxc_test_box::guest

  #include lxc_test_box::lxc
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
  
  # include lxc_test_box::host::rootfs::cleanup rpmforge 消す用
  
     Class['lxc_test_box::rootfs::base']
  -> Class['lxc_test_box::rootfs::install']
  -> Class['lxc_test_box::rootfs::config']
}

class lxc_test_box::guest {

}
