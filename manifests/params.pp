class reposado::params {
  $user = 'reposado'
  $group = 'reposado'
  $base_dir = '/srv/reposado'
  $reposado_root = "${base_dir}/reposado"
  $metadata_dir = "${base_dir}/metadata"
  $document_root = "${base_dir}/html"
  $cronjob_time = '0:30'
  $server_name = "${::hostname}.${::domain}"
  $local_catalog_url_base = "http://${server_name}"
  $git_source = 'https://github.com/wdas/reposado'
  $git_revision = undef
}