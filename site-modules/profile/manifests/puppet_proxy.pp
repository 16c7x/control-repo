#
class profile::puppet_proxy{
  include ::haproxy
  haproxy::listen { 'proxy1':
    collect_exported => false,
    ipaddress        => $::ipaddress,
    ports            => '8140',
  }
  haproxy::balancermember { 'compiler1':
    listening_service => 'puppet00',
    server_names      => 'compiler1.platform9.puppet.net',
    ipaddresses       => '10.234.5.134',
    ports             => '8140',
    options           => 'check',
  }
  haproxy::balancermember { 'compiler2':
    listening_service => 'puppet00',
    server_names      => 'compiler2.platform9.puppet.net',
    ipaddresses       => '10.234.5.149',
    ports             => '8140',
    options           => 'check',
  }
}
