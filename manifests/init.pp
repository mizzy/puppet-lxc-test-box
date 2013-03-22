class lxc-test-box {

  include lxc-test-box::package
  include lxc-test-box::config
  include lxc-test-box::service
  include lxc-test-box::cgroup
  include lxc-test-box::network
  include lxc-test-box::lxc

}
