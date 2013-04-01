class lxc_test_box {
  include lxc_test_box::host
  include lxc_test_box::guest

  #include lxc_test_box::lxc

}

class lxc_test_box::host {
  include lxc_test_box::host::yumrepo
  include lxc_test_box::host::install
  include lxc_test_box::host::config
  include lxc_test_box::host::service
  include lxc_test_box::host::network
  include lxc_test_box::host::rootfs

     Class['lxc_test_box::host::yumrepo']
  -> Class['lxc_test_box::host::install']
  -> Class['lxc_test_box::host::config']
  -> Class['lxc_test_box::host::service']
  -> Class['lxc_test_box::host::network']
  -> Class['lxc_test_box::host::rootfs']
}

class lxc_test_box::guest {

}
