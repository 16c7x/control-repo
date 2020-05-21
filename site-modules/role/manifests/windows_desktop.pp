#
class role::windows_desktop {
  include ::profile::baseline::baseline
  notify { 'windows desktop role': }
}
