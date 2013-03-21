class lxc-test-box::lxc {

  include lxc-test-box::lxc::container
  include lxc-test-box::lxc::devices
  include lxc-test-box::lxc::config

  define setup( $ipaddress = '' ) {
    container::create { $name:   }
    devices::create   { $name:  require => Lxc::Container::Create[$name] }
    config::create    { $name: ipaddress => $ipaddress }
  }

}

