## Release 1.0.2

- support for macOS 10.14 ('Mojave')
- PDK updated to 1.9.0

## Release 1.0.1

- changed 'cronjob_time' from String to Regexp, and fixed documentation
- the default values for 'document_root', 'metadata_dir', 'reposado_root' and 'cronjob_command' now ultimately depend on 'base_dir', instead of their counterparts in params.pp

## Release 1.0.0

#### Features

- puppet 4 support:
  - added types
  - migrated functions from legacy to modern Ruby API
  - migrated erb to epp
- added 'document_root' parameter to both reposado and reposado::apache_vhost classes
- all parameters now have defaults in params.pp
- support for macOS High Sierra (10.13)

#### Bugfixes

- fixed catalog compilation error when user and/or group not managed

## Release 0.2.1

#### Bugfixes

- fixed macOS Sierra rewrite missing from the vhost rewrites
- fixed 'open ended dependency warning' when running the tests

## Release 0.2.0

#### Features

- added macOS Sierra support
- support for 'HumanReadableSizes' key in preferences.plist
- support for setting an apache port in the vhost

#### Bugfixes

- added rspec tests
- bugfixes for bugs found with the above

## Release 0.1.0

Initial release.
