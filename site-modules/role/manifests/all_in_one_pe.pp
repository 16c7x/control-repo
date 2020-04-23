#
class role::all_in_one_pe {
  include ::profile::master::nodegroups
  include ::profile::master::puppetmaster
  include ::profile::base
  notify { 'All in one pe': }
}
