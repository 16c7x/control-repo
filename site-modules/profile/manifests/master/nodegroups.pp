class profile::master::nodegroups {

  node_group { 'PE Master':
    rule                 => ['and', ['=', ['fact', 'function'], 'compiler']],
  }
  node_group { 'roll::test_application':
    ensure               => 'present',
    classes              => {'role::test_application' => {}},
    environment          => 'production',
    override_environment => false,
    parent               => 'All Nodes',
    rule                 => ['and', ['=', ['fact', 'function'], 'controler']],
  }
}
