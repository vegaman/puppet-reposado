class reposado::params {
  $user = 'reposado'
  $group = 'reposado'
  $base_dir = '/srv/reposado'
  $cronjob_time = '0:30'
  $cronjob_command = "${base_dir}/reposado/code/repo_sync"
  $git_source = 'https://github.com/wdas/reposado'
  $git_ensure = 'present'
  $git_revision = undef
  $server_name = "${::hostname}.${::domain}"
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
  $document_root = "${base_dir}/html"
}
