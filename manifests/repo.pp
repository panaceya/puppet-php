# == Class: php::repo
#
# Configure package repository
#
# === Authors
#
# Robin Gloster <robin.gloster@mayflower.de>
#
# === Copyright
#
# See LICENSE file
#
class php::repo {

  anchor { 'php::repo::begin': } ->
  anchor { 'php::repo::end': }

  case $::osfamily {
    'Debian': {
      # no anchors here because apt does that already
      case $::operatingsystem {
        'Debian': {
          include php::repo::debian
        }
        'Ubuntu': {
          include php::repo::ubuntu
        }
        default: {
          fail("No repo available for ${::osfamily}/${::operatingsystem}, please fork this module and add one in repo.pp")
        }
      }
    }
    'Suse': {
      include php::repo::suse

      Anchor['php::repo::begin'] ->
        Class['php::repo::suse'] ->
      Anchor['php::repo::end']
    }
    'RedHat': {
      include php::repo::rhel
    }
    default: {
      fail("No repo available for ${::osfamily}/${::operatingsystem}, please fork this module and add one in repo.pp")
    }
  }
}
