class reposado::apache_vhost (
  String $user                  = $::reposado::params::user,
  String $group                 = $::reposado::params::group,
  String $document_root         = $::reposado::params::document_root,
  String $server_name           = $::reposado::params::server_name,
  String $server_port           = $::reposado::params::server_port,
  Array[String] $apple_catalogs = $::reposado::params::apple_catalogs) inherits ::reposado::params {
  include ::apache

  $rewrite_rules = rewrites($apple_catalogs)

  apache::vhost { $server_name:
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
