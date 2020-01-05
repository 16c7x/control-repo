class role::puppetmaster {

  class { '::selinux' :
    mode => 'disabled'
    }
}
