#
class profile::baseline::linux {

  class { '::ssh' :
    sshd_x11_forwarding => 'yes',
  }

  class { '::selinux' :
    mode => 'disabled'
  }
}
