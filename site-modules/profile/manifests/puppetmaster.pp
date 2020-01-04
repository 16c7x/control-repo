class profile::puppetmaster {
  notify { "Conf Dir : ${settings::confdir}": }
  ini_setting { 'policy-based autosigning':
    setting => 'autosign',
    path    => "${settings::confdir}/puppet.conf",
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
        'secret'   => 'hunter2'
        'validity' => '7200',
      }
    },
  }
}
