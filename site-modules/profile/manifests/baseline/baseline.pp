#
class profile::baseline::baseline {
  notify { 'linux baseline profile': }

  case $::osfamily {
    'windows': {
      class { 'profile::baseline::windows':}
    }
    'RedHat': {
      class { 'profile::baseline::linux':}
    }
    default: {
      notify { 'OS not supported': }
    }
  }
}
