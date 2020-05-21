# node manager configuration
class profile::master::nodegroups {

  node_group { 'PE Master':
    rule                 => ['and', ['=', ['fact', 'function'], 'compiler']],
  }
  node_group { 'PE Controler':
    ensure               => 'present',
    classes              => {'puppet_enterprise::profile::controller' => {}},
    environment          => 'production',
    override_environment => false,
    parent               => 'All Nodes',
    rule                 => ['and', ['=', ['fact', 'function'], 'controler']],
  }
  node_group { 'role::lab_cd4pe':
    ensure               => 'present',
    classes              => {'role::lab_cd4pe' => {}},
    environment          => 'production',
    override_environment => false,
    parent               => 'All Nodes',
    rule                 => ['and', ['=', ['fact', 'function'], 'cd4pe']],
  }
  node_group { 'role::test_application':
    ensure               => 'present',
    classes              => {'role::test_application' => {}},
    environment          => 'production',
    override_environment => false,
    parent               => 'All Nodes',
    rule                 => ['and', ['=', ['fact', 'function'], 'testapp']],
  }
  node_group { 'role::windows_desktop':
    ensure               => 'present',
    classes              => {'role::windows' => {}},
    environment          => 'production',
    override_environment => false,
    parent               => 'All Nodes',
    rule                 => ['and', ['=', ['fact', 'function'], 'windows_desktop']],
  }
}
