class lxc-test-box {

  include lxc-test-box::package
  include lxc-test-box::config
  include lxc-test-box::service
  include lxc-test-box::cgroup
  include lxc-test-box::network
  include lxc-test-box::lxc

  lxc::setup { 'base':   ipaddress => '172.16.0.2' }
  lxc::setup { 'manage': ipaddress => '172.16.0.3' }
  lxc::setup { 'smtp':   ipaddress => '172.16.0.4' }

}
