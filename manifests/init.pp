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
  $user                   = $::reposado::params::user,
  $group                  = $::reposado::params::group,
  $base_dir               = $::reposado::params::base_dir,
  $git_source             = $::reposado::params::git_source,
  $git_revision           = $::reposado::params::git_revision,
  $reposado_root          = $::reposado::params::reposado_root,
  $metadata_dir           = $::reposado::params::metadata_dir,
  $document_root          = $::reposado::params::document_root,
  $cronjob_time           = $::reposado::params::cronjob_time,
  $local_catalog_url_base = $::reposado::params::local_catalog_url_base,
  $manage_user            = true,
  $manage_group           = true,
  $manage_git             = true,
  $manage_cronjob         = true) inherits ::reposado::params {
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

  if $manage_git {
    package { 'git': ensure => 'present'; }
  }

  if $manage_cronjob {
    $cronjob_time_as_array = split($cronjob_time, ':')
    $cronjob_hour = $cronjob_time_as_array[0]
    $cronjob_minute = $cronjob_time_as_array[1]

    cron { 'repo_sync':
      command => "${reposado_root}/code/repo_sync",
      user    => $user,
      hour    => $cronjob_hour,
      minute  => $cronjob_minute;
    }
  }

  vcsrepo { $reposado_root:
    ensure   => 'present',
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
