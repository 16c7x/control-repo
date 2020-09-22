# CIS
class profile::cis {
  class {'::secure_linux_cis':
    time_servers  => ['time1.google.com', 'time1.google.com'],
    profile_type  => 'server',
    allow_users   => ['centos'],
  }
}
