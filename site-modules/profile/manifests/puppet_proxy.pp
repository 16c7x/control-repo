#
class profile::puppet_proxy{
  include ::haproxy
  haproxy::listen { 'puppet00':
    collect_exported => false,
    ipaddress        => $::ipaddress,
    ports            => '8140',
  }
  haproxy::balancermember { 'compiler3':
    listening_service => 'puppet00',
    server_names      => 'compiler3.platform9.puppet.net',
    ipaddresses       => '192.168.0.13',
    ports             => '8140',
    options           => 'check',
  }
  #haproxy::balancermember { 'compiler2':
  #  listening_service => 'puppet00',
  #  server_names      => 'peubuntu1804.platform9.puppet.net',
  #  ipaddresses       => '192.168.0.27',
  #  ports             => '8140',
  #  options           => 'check',
  #}
}
