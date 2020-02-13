#
class profile::puppetmaster {

  notify { 'Puppet Master Profile': }

  node_group { 'PE Compiler':
    ensure               => 'present',
    #classes              => {'puppet_enterprise::profile::mcollective::agent' => {}},
    environment          => 'production',
    #id                   => '4cdec347-20c6-46d7-9658-7189c1537ae9',
    override_environment => 'false',
    parent               => 'PE Master',
    rule                 => ['and', ['~', ['fact', 'function'], 'compiler']],
  }

  ini_setting { 'policy-based autosigning':
    setting => 'autosign',
    path    => "${settings::confdir}/puppet.conf",
    section => 'master',
    value   => '/opt/puppetlabs/puppet/bin/autosign-validator',
    notify  => Service['pe-puppetserver'],
  }

  class { ::autosign :
    ensure => 'latest',
    config => {
      'general'   => {
      'loglevel' => 'INFO',
      },
      'jwt_token' => {
      'secret'   => 'hunter2'
      #'validity' => '7200',
      }
    },
  }
}
