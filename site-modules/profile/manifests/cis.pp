# CIS
class profile::cis {
  #class {'::secure_linux_cis':
  #  time_servers  => ['time1.google.com', 'time1.google.com'],
  #  profile_type  => 'server',
  #  allow_users   => ['centos'],
  #}
  include secure_linux_cis::rules::ensure_separate_partition_exists_for_var_log
}
