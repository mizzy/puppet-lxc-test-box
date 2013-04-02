class lxc_test_box::host::rootfs {
  $base_dir = '/var/rootfs/sl6'

  include lxc_test_box::host::rootfs::base

  # include lxc_test_box::host::rootfs::cleanup rpmforge 消す用
  
}
