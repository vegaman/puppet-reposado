require 'spec_helper'

describe 'reposado' do
  let(:facts) do
    {
      :hostname => 'reposado',
      :domain => 'my.domain'
    }
  end

  context 'with defaults for all parameters' do
    it { is_expected.to compile }
    it { is_expected.to contain_class('reposado') }
    it { is_expected.to contain_vcsrepo('/srv/reposado/reposado') }

    def preferences
<<-HEREDOC
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>LocalCatalogURLBase</key>
    <string>http://reposado.my.domain</string>
    <key>UpdatesMetadataDir</key>
    <string>/srv/reposado/metadata</string>
    <key>UpdatesRootDir</key>
    <string>/srv/reposado/html</string>
</dict>
</plist>
      HEREDOC
    end
    it { is_expected.to contain_file('/srv/reposado/reposado/code/preferences.plist').with_content(preferences) }
  end

  context 'with additional parameters' do
    let(:params) do
      {
        :apple_catalogs          => ['10.9'],
        :additional_curl_options => ["proxy = \"web-proxy.yourcompany.com:8080\""],
        :preferred_localizations => ["English", "en"],
        :curl_path               => "/usr/local/bin/curl",
        :repo_sync_log_file      => "/var/log/reposado_sync.log",
        :human_readable_sizes    => true
      }
    end

    def preferences
<<-HEREDOC
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>LocalCatalogURLBase</key>
    <string>http://reposado.my.domain</string>
    <key>UpdatesMetadataDir</key>
    <string>/srv/reposado/metadata</string>
    <key>UpdatesRootDir</key>
    <string>/srv/reposado/html</string>
    <key>AppleCatalogURLs</key>
    <array>
        <string>https://swscan.apple.com/content/catalogs/others/index-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog</string>
    </array>
    <key>AdditionalCurlOptions</key>
    <array>
        <string>proxy = "web-proxy.yourcompany.com:8080"</string>
    </array>
    <key>PreferredLocalizations</key>
    <array>
        <string>English</string>
        <string>en</string>
    </array>
    <key>CurlPath</key>
    <string>/usr/local/bin/curl</string>
    <key>RepoSyncLogFile</key>
    <string>/var/log/reposado_sync.log</string>
    <key>HumanReadableSizes</key>
    <true/>
</dict>
</plist>
      HEREDOC
    end

    it { is_expected.to contain_file('/srv/reposado/reposado/code/preferences.plist').with_content(preferences) }
  end

  context 'without managing user and group' do
    let(:params) do
      {
        :manage_user  => false,
        :manage_group => false
      }
    end

    it { is_expected.to compile }
    it { is_expected.to_not contain_user('reposado') }
    it { is_expected.to_not contain_group('reposado') }
  end
end
