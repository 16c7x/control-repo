#
class profile::baseline::windows {
  notify { 'windows baseline profile': }

  require chocolatey

  Package { provider => chocolatey, }

  package { '7zip.install':
    ensure   => installed,
  }

  reboot { 'after7zip':
    subscribe  => Package['7zip.install'],
  }

  group { 'Localgrp':
    ensure => present,
  }

  user { 'Localusr':
    ensure  => present,
    comment => 'Local user',
    group   => 'Localgrp',
  }
}
