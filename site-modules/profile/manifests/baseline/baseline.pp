#
class profile::baseline::baseline {
  notify { 'linux baseline profile': }

  case $::osfamily {
    'windows': {
      class { 'windows':}
    }
    'RedHat': {
      class { 'linux':}
    }
    default: {
      notify { 'OS not supported': }
    }
  }
}
