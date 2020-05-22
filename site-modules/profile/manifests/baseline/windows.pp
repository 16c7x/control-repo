#
# Had to put the whole path in a variable or Puppet complained about
# unrecognised escape sequence. Don't think it likes Windows backwards shashes.
class profile::baseline::windows (
  $localuser = 'bob',
  $localgroup = 'bobtastic',
  $localdirectory = 'C:\Program Files\bobsthings', 
){
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

  group { $localgroup:
    ensure => present,
  }

  user { $localuser:
    ensure  => present,
    groups  => $localgroup,
    comment => 'Bob is a knob',
  }

  file { $localdirectory:
    ensure => directory,
    owner  => $localuser,
    group  => $localgroup,  # Not sure if this is actualy doing anything.
  }

  acl { $localdirectory:
    permissions => [
      { identity = $localuser, rights => ['full']},
      { identity = $localgroup, rights => ['read']}
    ],
  }

}
