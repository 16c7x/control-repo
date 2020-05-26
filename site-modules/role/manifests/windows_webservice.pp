#
class role::windows_webservice {
  include ::profile::baseline::baseline
  include ::profile::iis
}
