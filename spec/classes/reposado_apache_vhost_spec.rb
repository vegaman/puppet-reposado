require 'spec_helper'

describe 'reposado::apache_vhost' do
  let(:facts) do
    {
      :operatingsystemrelease => '16.04',
      :osfamily => 'Debian',
      :operatingsystem => 'Ubuntu',
      :lsbdistrelease => 16.04,
      :hostname => 'reposado',
      :domain => 'my.domain'
    }
  end
  context 'with defaults for all parameters' do
    it { is_expected.to compile }
    it { is_expected.to contain_apache__vhost('reposado.my.domain').with(
      'port'          => '80',
      'docroot'       => '/srv/reposado/html',
      'docroot_owner' => 'reposado',
      'docroot_group' => 'reposado',
      'directories'   => [{
        'path'           => '/srv/reposado/html',
        'options'        => ['Indexes', 'FollowSymLinks'],
        'allow_override' => ['None'],
        'require'        => 'all granted'
        }
      ],
      'rewrites' => [{ "rewrite_cond" => "%{HTTP_USER_AGENT} Darwin/8", "rewrite_rule" => "^/index(.*)\.sucatalog$ /content/catalogs/index$1.sucatalog [L]" },
        { "rewrite_cond" => "%{HTTP_USER_AGENT} Darwin/9", "rewrite_rule" => "^/index(.*)\.sucatalog$ /content/catalogs/others/index-leopard.merged-1$1.sucatalog [L]" },
        { "rewrite_cond" => "%{HTTP_USER_AGENT} Darwin/10", "rewrite_rule" => "^/index(.*)\.sucatalog$ /content/catalogs/others/index-leopard-snowleopard.merged-1$1.sucatalog [L]" },
        { "rewrite_cond" => "%{HTTP_USER_AGENT} Darwin/11", "rewrite_rule" => "^/index(.*)\.sucatalog$ /content/catalogs/others/index-lion-snowleopard-leopard.merged-1$1.sucatalog [L]" },
        { "rewrite_cond" => "%{HTTP_USER_AGENT} Darwin/12", "rewrite_rule" => "^/index(.*)\.sucatalog$ /content/catalogs/others/index-mountainlion-lion-snowleopard-leopard.merged-1$1.sucatalog [L]" },
        { "rewrite_cond" => "%{HTTP_USER_AGENT} Darwin/13", "rewrite_rule" => "^/index(.*)\.sucatalog$ /content/catalogs/others/index-10.9-mountainlion-lion-snowleopard-leopard.merged-1$1.sucatalog [L]" },
        { "rewrite_cond" => "%{HTTP_USER_AGENT} Darwin/14", "rewrite_rule" => "^/index(.*)\.sucatalog$ /content/catalogs/others/index-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1$1.sucatalog [L]" },
        { "rewrite_cond" => "%{HTTP_USER_AGENT} Darwin/15", "rewrite_rule" => "^/index(.*)\.sucatalog$ /content/catalogs/others/index-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1$1.sucatalog [L]" },
        { "rewrite_cond" => "%{HTTP_USER_AGENT} Darwin/16", "rewrite_rule" => "^/index(.*)\.sucatalog$ /content/catalogs/others/index-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1$1.sucatalog [L]" },
        { "rewrite_cond" => "%{HTTP_USER_AGENT} Darwin/17", "rewrite_rule" => "^/index(.*)\.sucatalog$ /content/catalogs/others/index-10.13-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1$1.sucatalog [L]" } ],
      'servername'    => 'reposado.my.domain' ) }
  end
end
