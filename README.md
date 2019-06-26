# reposado

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with reposado](#setup)
    * [What reposado affects](#what-reposado-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with reposado](#beginning-with-reposado)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Installs Greg Neagle's Reposado (https://github.com/wdas/reposado) on an Ubuntu server. Reposado is an open-source macOS Software Update Server.

## Module Description

This module sets up syncing of macOS updates through Reposado, and, optionally, an Apache vhost to allow for replication of those updates.

## Setup

### What reposado affects

* Make sure `base_dir` is large enough to be able to hold all updates (my server is currently holding 232 Gb worth of updates).
* `reposado::apache_vhost` includes `puppetlabs/apache`.

### Beginning with reposado

Minimal usage:
```puppet
class { 'reposado': }
```

If you wish to enable the Apache vhost, you need to include the `reposado::apache_vhost` class:
```puppet
class { 'reposado::apache_vhost': }
```

## Usage

Example configuration through hiera:
~~~
reposado::base_dir: '/var/www/reposado'
reposado::document_root: "%{hiera('reposado::base_dir')}/html"
reposado::git_ensure: 'latest'
reposado::apple_catalogs:
  - '10.10'
  - '10.11'

reposado::apache_vhost::document_root: "%{alias('reposado::document_root')}"
reposado::apache_vhost::apple_catalogs: "%{alias('reposado::apple_catalogs')}"
~~~

## Reference

The module uses `puppetlabs/vcsrepo` to clone https://github.com/wdas/reposado.

### Parameters

#### `reposado` class

The `reposado` class takes the following:

##### `user`

The user that owns the Reposado files, both installed and downloaded, and runs the cron job. Default: 'reposado'.

##### `group`

All reposado files belong to this group. Default: 'reposado'.

##### `base_dir`

The directory that holds all Reposado related files and directories. Default: '/srv/reposado'.

##### `document_root`

The directory where all the downloads are cached, and that serves as document root for the webserver. Default '`base_dir`/html'

##### `metadata_dir`

The directory wherre reposado stores its metadata. Default '`base_dir`/metadata'

##### `reposado_root`

The directory the reposado git repository is cloned to. Default '`base_dir`/reposado'

##### `git_source`

The git repository to clone Reposado from. Default: 'https://github.com/wdas/reposado'

##### `git_ensure`

How to clone the git repository. 'latest' keeps up with the latest revision, 'present' clones the repository, but does not keep up with the latest revision. Default: 'present'.

##### `git_revision`

Which revision to clone from the git repository. Default: undef (i.e. the HEAD revision).

##### `cronjob_time`

The time to run the sync cron job. Format: 'HH:MM', you can omit a leading '0' in 'HH'. Default: '0:30'.

##### `cronjob_command`

The cron job command to run. Default: '`reposado_root`/code/repo_sync'. If you would like to remove deprecated updates by default, set this to '`reposado_root`/code/repo_sync && `reposado_root`/code/repoutil --purge-product all-deprecated', for example.

##### `server_name`

Name of the server. Default: '`hostname`.`domain`'.

##### `local_catalog_url_base`

Url base for the local catalog. Override this if you need to use HTTPS. Default: 'http://`server_name`'

##### `manage_user`

Whether puppet should manage `user`. Default: true.

##### `manage_group`

Whether puppet should manage `group`. Default: true.

##### `manage_cronjob`

Whether puppet should manage the sync cron job. Default: true.

##### `packages`

Packages that need to be installed by this module. Default: '['git', 'curl', 'python']'. 

##### `apple_catalogs`

An array of operating system names, that specifies the Apple SUS catalog URLs to replicate. If left empty, this module follows the Reposado default, and replicates all available updates. The operating system names can be either the macOS version (e.g. '10.8', '10.10'), or its name (e.g. 'mountainlion', 'yosemite'). Names are lowercase, and without separating blanks, if more than one word. Default: '[]'.

##### `additional_curl_options`

Value of the 'AdditionalCurlOptions' key in Reposado's Preferences.plist configuration file. Default: '[]'.

##### `preferred_localizations`

Value of the 'PreferredLocalizations' key in Reposado's Preferences.plist configuration file. Default: '[]'.

##### `curl_path`

Value of the 'CurlPath' key in Reposado's Preferences.plist configuration file. Default: undef.

##### `repo_sync_log_file`

Value of the 'RepoSyncLogFile' key in Reposado's Preferences.plist configuration file. Default: undef.

##### `human_readable_sizes`

Value of the 'HumanReadableSizes' key in Reposado's Preferences.plist configuration file. Boolean, defaults to false.

#### `reposado::apache_vhost` class

##### `user`

The user that owns the document root. Default: 'reposado'.

##### `group`

All files in the document root belong to this group. Default: 'reposado'.

##### `base_dir`

The directory that holds all Reposado related files and directories. Default: '/srv/reposado'.

##### `document_root`

Path to the document root. Default: '`base_dir`/html'.

##### `server_name`

Name of the server. Default: '`hostname`.`domain`'.

##### `server_port`

Apache port for this vhost.

##### `apple_catalogs`

An array of operating system names, that specifies the Apple SUS catalog URLs to replicate. If left empty, this module follows the Reposado default, and replicates all available updates. The operating system names can be either the macOS version (e.g. '10.8', '10.10'), or its name (e.g. 'mountainlion', 'yosemite'). Names are lowercase, and without separating blanks, if more than one word. Default: '[]'.

## Limitations

Currently tested on Ubuntu 14.04 and 16.04 only.

## Development

Run `rake spec` to run all tests.
