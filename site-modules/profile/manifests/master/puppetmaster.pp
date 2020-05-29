#
class profile::master::puppetmaster {

# Normaly this would be in a module but to keep things in one place the file share will come from 
# profile so need to add it to the file share list.
  ini_setting { 'site-modules-path':
    ensure            => present,
    key_val_separator => ' ',
    section           => 'site-modules',
    setting           => 'path',
    value             => '/etc/puppetlabs/code/environments/production/site-modules/profile/files',
    path              => '/etc/puppetlabs/puppet/fileserver.conf',
  }

  ini_setting { 'site-modules-allow':
    ensure            => present,
    key_val_separator => ' ',
    section           => 'site-modules',
    setting           => 'allow',
    value             => '*',
    path              => '/etc/puppetlabs/puppet/fileserver.conf',
  }

# Autosign config.
  ini_setting { 'policy-based autosigning':
    setting => 'autosign',
    path    => "${confdir}/puppet.conf",
    section => 'master',
    value   => '/opt/puppetlabs/puppet/bin/autosign-validator',
    notify  => Service['pe-puppetserver'],
  }

  class { ::autosign:
    ensure => 'latest',
    config => {
      'general' => {
        'loglevel' => 'INFO',
      },
      'jwt_token' => {
        'secret'   => 'hunter2',
        'validity' => '7200',
      }
    },
  }

# Ensure the eyaml keys have the right perms.
  file {'/etc/puppetlabs/puppet/keys/private_key.pkcs7.pem':
    ensure => file,
    owner  => 'root',
    group  => 'pe-puppet',
    mode   => '0440',
  }

  file {'/etc/puppetlabs/puppet/keys/public_key.pkcs7.pem':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0444',
  }
}
