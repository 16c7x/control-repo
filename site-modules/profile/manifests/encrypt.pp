# cd4pe
class profile::encrypt {
  file { '/etc/secretfile.cfg':
  ensure  => file,
  #content => 'A string to find in the catalog 123456789'.node_encrypt::secret
  content => 'A string to find in the catalog 123456789'
  }
}
