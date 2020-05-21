#
class profile::baseline::linux {
  notify { 'linux baseline profile': }

  class { '::ssh' :
    sshd_x11_forwarding => 'yes',
  }

  class { '::selinux' :
    mode => 'disabled'
  }
}
