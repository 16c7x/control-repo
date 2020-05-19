#
class role::lab_cd4pe {
  include ::profile::cd4pe
  notify { 'cd4pe role': }
}
