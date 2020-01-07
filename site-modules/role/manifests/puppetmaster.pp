#
class role::puppetmaster {

  notify { 'Puppet Master Role': }

  include profile::base
  include profile::puppetmaster

}
