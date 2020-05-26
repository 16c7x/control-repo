# cd4pe
class profile::cd4pe {
  class { 'cd4pe' :
    cd4pe_version => '3.x',
  }
}
