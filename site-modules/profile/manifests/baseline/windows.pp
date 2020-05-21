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

  group { 'localgrp':
    ensure => present,
  }

  user { 'localusr':
    ensure  => present,
    comment => 'Local user',
    group   => 'localgrp',
  }
}
