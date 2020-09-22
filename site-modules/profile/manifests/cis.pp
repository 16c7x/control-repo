# CIS
class profile::cis {
  class {'::secure_linux_cis':
    time_servers  => ['time1.google.com', 'time1.google.com'],
    profile_type  => 'centos',
    allow_users   => 'trusteduser',
  }
}
