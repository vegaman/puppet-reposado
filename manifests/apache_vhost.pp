class reposado::apache_vhost (
  $user           = $::reposado::params::user,
  $group          = $::reposado::params::group,
  $document_root  = "${::reposado::params::base_dir}/html",
  $server_name    = $::reposado::params::server_name,
  $server_port    = $::reposado::params::server_port,
  $apple_catalogs = []) inherits ::reposado::params {
  include ::apache
  include ::apache::mod::rewrite

  $rewrite_rules = rewrites($apple_catalogs)

  ::apache::vhost { $server_name:
    port          => $server_port,
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