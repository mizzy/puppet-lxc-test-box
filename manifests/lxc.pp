class lxc-test-box::lxc {

  include lxc-test-box::lxc::container
  include lxc-test-box::lxc::devices
  include lxc-test-box::lxc::config

  define setup( $ipaddress_eth0 = '', $ipaddress_eth1 ) {
    host { "$name.lxc-test-box": ip => $ipaddress_eth1 }
    container::create { $name:   }
    devices::create   { $name:  require => Lxc::Container::Create[$name] }
    config::create    { $name:
      ipaddress_eth0 => $ipaddress_eth0,
      ipaddress_eth1 => $ipaddress_eth1,
      require        => Lxc::Container::Create[$name],
    }
  }

}

