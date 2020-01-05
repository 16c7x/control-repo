class role::puppetmaster {

  class { '::selinux' :
    mode => 'disabled'
  }
  class { '::ssh' : 
    sshd_x11_forwarding => 'yes',
  }
  notify { "puppet master role": }
}
