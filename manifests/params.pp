class reposado::params {
  $user = 'reposado'
  $group = 'reposado'
  $base_dir = '/srv/reposado'
  $cronjob_time = '0:30'
  $git_source = 'https://github.com/wdas/reposado'
  $git_ensure = 'present'
  $git_revision = undef
  $server_name = "${::hostname}.${::domain}"
  $local_catalog_url_base = "http://${server_name}"
  $manage_user = true
  $manage_group = true
  $manage_cronjob = true
  $packages = ['git', 'python', 'curl']
  $apple_catalogs = []
  $additional_curl_options = []
  $preferred_localizations = []
  $curl_path = undef
  $repo_sync_log_file = undef
  $human_readable_sizes = false
  $server_port = '80'
}
