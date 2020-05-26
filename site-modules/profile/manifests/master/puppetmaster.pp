#
class profile::master::puppetmaster {

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
}
