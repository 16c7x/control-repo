class role::puppetmaster {

  notify { "Puppet Master Role": }

  class { '::selinux' :
    mode => 'disabled'
  }
  class { '::ssh' : 
    sshd_x11_forwarding => 'yes',
  }
}
