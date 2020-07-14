# This class sets up an iis webservice.
class profile::iis {

  $iis_features = ['Web-WebServer','Web-Scripting-Tools']
  windowsfeature { $iis_features:
    ensure => present,
  }

  iis_site {'Default Web Site':
    ensure  => absent,
    require => Windowsfeature['Web-WebServer'],
  }

  iis_site { 'animal':
    ensure          => 'started',
    physicalpath    => 'c:\\inetpub\\animal',
    #defaultpage     => 'index.html',   # This doesn't appear to be idempotent. 
    applicationpool => 'DefaultAppPool',
    require         => [
      File['animal'],
      Iis_site['Default Web Site']
    ]
  }

  file { 'animal':
    ensure => 'directory',
    path   => 'c:\\inetpub\\animal',
  }

  file { 'images':
    ensure => 'directory',
    path   => 'c:\\inetpub\\animal\\images',
  }

  file {'index.html':
    ensure => 'file',
    path   => 'c:\\inetpub\\animal\\index.html',
    source => 'puppet:///site-modules/index.html',
    #source => 'puppet:///modules/profile/index.html',
  }

  file {'animal.gif':
    ensure => 'file',
    path   => 'c:\\inetpub\\animal\\images\\animal.gif',
    source => 'puppet:///site-modules/animal.gif',
  }

  iis_virtual_directory { 'vdir':
    ensure       => 'present',
    sitename     => 'animal',
    physicalpath => 'c:\\inetpub\\animal\\images',
    require      => File['images'],
  }
}
