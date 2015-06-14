class reposado::params {
  $user = 'reposado'
  $group = 'reposado'
  $base_dir = '/srv/reposado'
  $cronjob_time = '0:30'
  $cronjob_command = '/srv/reposado/reposado/code/repo_sync'
  $server_name = "${::hostname}.${::domain}"
  $git_source = 'https://github.com/wdas/reposado'
  $git_ensure = 'present'
}
