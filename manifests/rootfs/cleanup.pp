class lxc_test_box::rootfs::cleanup {
  $base_dir = $lxc_test_box::rootfs::base_dir

  # rpmforge は lxc を入れるために定義しているが、実際のサーバでは
  # 利用してないので削除。利用しちゃうと、nrpe が nagios-nrpe と
  # いう名前で入ってしまい、マニフェストがうまく機能しなくなる。
  #
  # また、file リソースで定義すると、rootfs::base でこのファイルを置く
  # 定義と被るので怒られるので、exec で実行する。
  # title で定義したリソース名とは別に、File[ファイル名] という
  # エイリアスをつくるみたい。
  #
  # エラーの内容はこれ。
  # Error: Cannot alias File[/etc/yum.repos.d/rpmforge.repo for rootfs] to
  # ["/var/rootfs/sl6/etc/yum.repos.d/rpmforge.repo"] at /home/mizzy/lxc_test_box/
  # manifests/rootfs/base.pp:22; resource ["File", "/var/rootfs/sl6/etc/yum.repos.d/
  # rpmforge.repo"] already declared at /home/mizzy/lxc_test_box/manifests/rootfs/
  #cleanup.pp:7

  exec { "Remove /etc/yum.repos.d/rpmforge.repo for rootfs":
    command => "/bin/rm $base_dir/etc/yum.repos.d/rpmforge.repo",
    onlyif  => "test -f $base_dir/etc/yum.repos.d/rpmforge.repo",
  }

}
