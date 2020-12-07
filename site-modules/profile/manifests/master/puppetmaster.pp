#
class profile::master::puppetmaster {

# Add this at some point
# puppet_enterprise::profile::console::rbac_session_timeout


# To keep everything in one place and not have to create a seperate module I'll file share a file from profile.
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
    ensure  => file,
    owner   => 'root',
    group   => 'pe-puppet',
    mode    => '0440',
    content => lookup('profile::master::puppetmaster::private_key'),
  }

  file {'/etc/puppetlabs/puppet/keys/public_key.pkcs7.pem':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => lookup('profile::master::puppetmaster::public_key'),
  }
}
