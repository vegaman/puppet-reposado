class reposado::apache_vhost (
  $user          = $::reposado::params::user,
  $group         = $::reposado::params::group,
  $document_root = "${::reposado::params::base_dir}/html",
  $server_name   = $::reposado::params::server_name) inherits ::reposado::params 
{
  include ::apache
  include ::apache::mod::rewrite

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
    rewrites      => [
      {
        rewrite_cond => '%{HTTP_USER_AGENT} Darwin/8',
        rewrite_rule => '^/index(.*)\.sucatalog$ /content/catalogs/index$1.sucatalog [L]'
      }
      ,
      {
        rewrite_cond => '%{HTTP_USER_AGENT} Darwin/9',
        rewrite_rule => '^/index(.*)\.sucatalog$ /content/catalogs/others/index-leopard.merged-1$1.sucatalog [L]'
      }
      ,
      {
        rewrite_cond => '%{HTTP_USER_AGENT} Darwin/10',
        rewrite_rule => '^/index(.*)\.sucatalog$ /content/catalogs/others/index-leopard-snowleopard.merged-1$1.sucatalog [L]'
      }
      ,
      {
        rewrite_cond => '%{HTTP_USER_AGENT} Darwin/11',
        rewrite_rule => '^/index(.*)\.sucatalog$ /content/catalogs/others/index-lion-snowleopard-leopard.merged-1$1.sucatalog [L]'
      }
      ,
      {
        rewrite_cond => '%{HTTP_USER_AGENT} Darwin/12',
        rewrite_rule => '^/index(.*)\.sucatalog$ /content/catalogs/others/index-mountainlion-lion-snowleopard-leopard.merged-1$1.sucatalog [L]'
      }
      ,
      {
        rewrite_cond => '%{HTTP_USER_AGENT} Darwin/13',
        rewrite_rule => '^/index(.*)\.sucatalog$ /content/catalogs/others/index-10.9-mountainlion-lion-snowleopard-leopard.merged-1$1.sucatalog [L]'
      }
      ,
      {
        rewrite_cond => '%{HTTP_USER_AGENT} Darwin/14',
        rewrite_rule => '^/index(.*)\.sucatalog$ /content/catalogs/others/index-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1$1.sucatalog [L]'
      }
      ],
    servername    => $server_name;
  }
}