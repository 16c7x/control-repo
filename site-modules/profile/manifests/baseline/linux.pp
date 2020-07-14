#
class profile::baseline::linux {

  #class { '::ssh' :
  #  sshd_x11_forwarding => 'yes',
  #  purge_unmanaged_sshkeys = false,
  #  storeconfigs_enabled = false,
  #}

  class { '::ssh' :}

  class { '::selinux' :
    mode => 'disabled'
  }
}
