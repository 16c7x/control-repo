class role::puppetmaster {

  class { '::selinux' :
    mode => 'disabled'
  }
  class { '::ssh' : }
}
