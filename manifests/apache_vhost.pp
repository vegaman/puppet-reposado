class reposado::apache_vhost (
  $user           = $::reposado::params::user,
  $group          = $::reposado::params::group,
  $document_root  = "${::reposado::params::base_dir}/html",
  $server_name    = $::reposado::params::server_name,
  $apple_catalogs = []) inherits ::reposado::params {
  include ::apache
  include ::apache::mod::rewrite

  $rewrite_rules = rewrite_rules($apple_catalogs)

  ::apache::vhost { $server_name:
    port          => '80',
    docroot       => $document_root,
    docroot_owner => $user,
    docroot_group => $group,
    directories   => [{
        path           => $document_root,
        options        => ['Indexes', 'FollowSymLinks'],
        allow_override => ['None'],
        require        => 'all granted'
      }
      ],
    rewrites      => $rewrite_rules,
    servername    => $server_name;
  }
}