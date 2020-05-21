#
class profile::baseline::windows {
  notify { 'windows baseline profile': }

  Package { provider => chocolatey, }

  package { '7zip.install':
    ensure   => installed,
  }

  reboot { 'after7zip':
    subscribe  => Package['7zip.install'],
  }
}
