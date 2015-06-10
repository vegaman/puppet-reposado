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

Installs Greg Neagle's Reposado (https://github.com/wdas/reposado) on an Ubuntu server. Reposado is an open-source OS X Software Update Server.

## Module Description

This module sets up syncing of OS X updates through reposado, and, optionally, an Apache Vhost to allow for replication of those updates.

## Setup

### What reposado affects

* Make sure ``base_dir`` is large enough to be able to hold all updates (my server is currently holding 232 Gb worth of updates).
* ``reposado::apache_vhost`` includes ``puppetlabs/apache``.

### Beginning with reposado

Minimal usage:
```puppet
class { 'reposado': }
```

If you wish to enable to Apache Vhost, you need to include the ``reposado::apache_vhost`` class:
```puppet
class { 'reposado::apache_vhost': }
```

## Reference

The module uses ``puppetlabs/vcsrepo`` to clone https://github.com/wdas/reposado. 

## Limitations

Currently only tested on Ubuntu 14.04.

## Release Notes

First release, might not work. No fancy options yet.
