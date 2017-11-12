class reposado::params {
  $user = 'reposado'
  $group = 'reposado'
  $base_dir = '/srv/reposado'
  $cronjob_time = '0:30'
  $cronjob_command = '/srv/reposado/reposado/code/repo_sync'
  $server_name = "${::hostname}.${::domain}"
  $server_port = '80'
  $git_source = 'https://github.com/wdas/reposado'
  $git_ensure = 'present'
  $packages = ['git', 'python', 'curl']
}
