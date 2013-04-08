class lxc_test_box::host::yumrepo {
  yumrepo { 'rpmforge':
    descr      => 'rpmforge',
    baseurl    => 'http://apt.sw.be/redhat/el6/en/$basearch/rpmforge',
    mirrorlist => 'http://mirrorlist.repoforge.org/el6/mirrors-rpmforge',
    enabled    => 1,
    protect    => 0,
    gpgcheck   => 0,
  }
}
