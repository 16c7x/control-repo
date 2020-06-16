#
class role::all_in_one_pe {
  #include ::profile::master::nodegroups
  #include ::profile::master::puppetmaster
  #include ::profile::baseline::baseline
}
