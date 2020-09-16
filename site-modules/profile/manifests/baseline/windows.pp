#
# Had to put the whole path in a variable or Puppet complained about
# unrecognised escape sequence. Don't think it likes Windows backwards shashes.
#
class profile::baseline::windows (
  $localuser = 'bob',
  $localgroup = 'bobtastic',
  $localdirectory = 'C:\Program Files\bobsthings',
){
  # Install chocolatey and then set it as our default package provider.
  require chocolatey
  #class {'chocolatey': }
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
  
  package { 'puppet-bolt':
    ensure => installed,
    notify => Reboot['postinstall'],
  }

  reboot { 'postinstall':
    apply => finished,
  }

# Setup out local user, group and directory. 
  group { $localgroup:
    ensure => present,
  }

  user { $localuser:
    ensure  => present,
    groups  => $localgroup,
    comment => "Bob's account",
  }

  file { $localdirectory:
    ensure => directory,
    owner  => $localuser,
    group  => $localgroup,  # Not sure if this is actualy doing anything.
  }

  acl { $localdirectory:
    permissions => [
      { identity => $localuser, rights => ['full']},
      { identity => $localgroup, rights => ['read']}
    ],
  }

# Enable Shutdown tracker
  registry_value { 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Reliability\ShutdownReasonOn':
    ensure => present,
    type   => dword,
    data   => '1',
  }

  registry_value { 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Reliability\ShutdownReasonUI':
    ensure => present,
    type   => dword,
    data   => '1',
  }

# Enable IE ESC
  registry_value { 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}\IsInstalled':
    ensure => present,
    #value  => 'IsInstalled',
    type   => dword,
    data   => '1',
  }

  registry_value { 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}\IsInstalled':
    ensure => present,
    #value  => 'IsInstalled',
    type   => dword,
    data   => '1',
  }

# Give our user login as a service rights.
# It's here: Control Panel > Administrative Tools > Local Security Policy > Local Policies > User Rights Assignment
#  local_security_policy { 'Log on as a service':
#    ensure         => 'present',
#    policy_setting => 'ServiceLogonRight',
#    policy_type    => 'Privilege Rights',
#    policy_value   => "cloudbase-init, ${localuser}, IIS APPPOOL\DefaultAppPool, NT SERVICE\ALL SERVICES",
#  }
}
