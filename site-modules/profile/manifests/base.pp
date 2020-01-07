# Baseline profile for all nodes
class profile::base {

  notify { 'Puppet Base Profile': }
  class { '::ssh' :
    sshd_x11_forwarding => 'yes',
  }

  class { '::selinux' :
    mode => 'disabled'
  }

}
