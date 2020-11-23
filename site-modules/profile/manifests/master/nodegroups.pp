# node manager configuration
class profile::master::nodegroups {

#  node_group { 'PE Master':
#    rule                 => ['and', ['=', ['fact', 'function'], 'compiler']],
#  }

$ruleshash = node_groups('PE Master')
$myrules = $ruleshash['PE Master']['rule']

# There is a mix of strings and tuples so need to normalize.
$rulesarray = $myrules.map |$x| { String($x)}

# Test if we have the compiler rule in place
if ! ("['=', ['fact', 'function'], 'compiler']" in $rulesarray) {
  $mynewrules = $myrules + [['=', ['fact', 'function'], 'compiler']]
} else {
  $mynewrules = $myrules
}

node_group { 'PE Master':
  rule                 => $mynewrules,
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
  node_group { 'role::windows_webservice':
    ensure               => 'present',
    classes              => {'role::windows_webservice' => {}},
    environment          => 'production',
    override_environment => false,
    parent               => 'All Nodes',
    rule                 => ['and', ['=', ['fact', 'function'], 'windows_webservice']],
  }
  node_group { 'role::windows_desktop':
    ensure               => 'present',
    classes              => {'role::windows_desktop' => {}},
    environment          => 'production',
    override_environment => false,
    parent               => 'All Nodes',
    rule                 => ['and', ['=', ['fact', 'function'], 'windows_desktop']],
  }

  node_group { 'role::encryptest':
    ensure               => 'present',
    classes              => {'role::encryptest' => {}},
    environment          => 'production',
    override_environment => false,
    parent               => 'All Nodes',
    rule                 => ['and', ['=', ['fact', 'function'], 'encrypt']],
  }
  
   node_group { 'role::dev_gitlab':
    ensure               => 'present',
    classes              => {'role::dev_gitlab' => {}},
    environment          => 'production',
    override_environment => false,
    parent               => 'All Nodes',
    rule                 => ['and', ['=', ['fact', 'function'], 'gitlab']],
  }
  
   node_group { 'role::cis_test':
    ensure               => 'present',
    classes              => {'role::cis_test' => {}},
    environment          => 'production',
    override_environment => false,
    parent               => 'All Nodes',
    rule                 => ['and', ['=', ['fact', 'function'], 'cis']],
  }
}
