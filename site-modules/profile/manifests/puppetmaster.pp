#
class profile::puppetmaster {

  notify { 'Puppet Master Profile': }

# This works but a bit crap.
  node_group { 'PE Master':
    rule                 => ['or',['and',['=',['fact', 'function'],'compiler']],['=', 'name', 'puppetmaster.lab']],
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
