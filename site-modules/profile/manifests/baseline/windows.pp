#
class profile::baseline::windows {
  notify { 'windows baseline profile': }

  require chocolatey

  Package { provider => chocolatey, }

  package { '7zip.install':
    ensure => installed,
    notify => Reboot['postinstall'],
  }

  package { 'git':
    ensure => installed,
    notify => Reboot['postinstall'],
  }

  package { 'vscode': 
    ensure => installed,
    notify => Reboot['postinstall'],
  }

  package { 'pdk': 
    ensure => installed,
    notify => Reboot['postinstall'],
  }
  reboot { 'postinstall':
    apply => finished,
  }

  group { 'Localgrp':
    ensure => present,
  }

  #user { 'Localusr':
  #  ensure  => present,
  #  group   => 'Localgrp',
  #  comment => 'Local user',
  #}
}
