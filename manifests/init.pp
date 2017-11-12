# == Class: reposado
#
# Base class to set up a Reposado service.
#
# === Authors
#
# Gerard Kok
#
# === Copyright
#
# Copyright 2015 Gerard Kok.
#
class reposado (
  String $user                           = $::reposado::params::user,
  String $group                          = $::reposado::params::group,
  String $base_dir                       = $::reposado::params::base_dir,
  String $document_root                  = $::reposado::params::document_root,
  String $git_source                     = $::reposado::params::git_source,
  String $git_ensure                     = $::reposado::params::git_ensure,
  Optional[String] $git_revision         = $::reposado::params::git_revision,
  String $cronjob_time                   = $::reposado::params::cronjob_time,
  String $cronjob_command                = $::reposado::params::cronjob_command,
  String $server_name                    = $::reposado::params::server_name,
  Boolean $manage_user                   = $::reposado::params::manage_user,
  Boolean $manage_group                  = $::reposado::params::manage_group,
  Boolean $manage_cronjob                = $::reposado::params::manage_cronjob,
  Array[String] $packages                = $::reposado::params::packages,
  Array[String] $apple_catalogs          = $::reposado::params::apple_catalogs,
  Array[String] $additional_curl_options = $::reposado::params::additional_curl_options,
  Array[String] $preferred_localizations = $::reposado::params::preferred_localizations,
  Optional[String] $curl_path            = $::reposado::params::curl_path,
  Optional[String] $repo_sync_log_file   = $::reposado::params::repo_sync_log_file,
  Boolean $human_readable_sizes          = $::reposado::params::human_readable_sizes) inherits ::reposado::params {
  $reposado_root = "${base_dir}/reposado"
  $metadata_dir = "${base_dir}/metadata"
  $local_catalog_url_base = "http://${server_name}"
  $catalog_urls = catalog_urls($apple_catalogs)

  if $manage_group {
    group { $group: ensure => 'present'; }
  }

  if $manage_user {
    user { $user:
      ensure => 'present',
      shell  => '/bin/bash',
      home   => $base_dir,
      gid    => $group;
    }
  }

  ensure_packages($packages, {'ensure' => 'present'})

  if $manage_cronjob {
    $cronjob_time_as_array = split($cronjob_time, ':')
    $cronjob_hour = $cronjob_time_as_array[0]
    $cronjob_minute = $cronjob_time_as_array[1]

    cron { 'repo_sync':
      command => $cronjob_command,
      user    => $user,
      hour    => $cronjob_hour,
      minute  => $cronjob_minute;
    }
  }

  vcsrepo { $reposado_root:
    ensure   => $git_ensure,
    owner    => $user,
    group    => $group,
    provider => 'git',
    require  => [User[$user], Group[$group]],
    source   => $git_source,
    revision => $git_revision;
  }

  file {
    [
      $base_dir,
      $metadata_dir]:
      ensure => 'directory',
      owner  => $user,
      group  => $group,
      mode   => '0755';

    "${reposado_root}/code/preferences.plist":
      ensure  => 'present',
      owner   => $user,
      group   => $group,
      mode    => '0644',
      content => template('reposado/preferences.plist.erb'),
      require => Vcsrepo[$reposado_root];

    $document_root:
      ensure => 'directory',
      owner  => $user,
      group  => $group,
      mode   => '0775';
  }
}
