#
class profile::baseline::windows {
  notify { 'windows baseline profile': }

  package { '7zip.install':
    ensure   => latest,
  }
  reboot { 'after7zip':
    subscribe  => Package['7zip.install'],
  }
}
