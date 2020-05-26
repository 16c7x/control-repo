# iis
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
    defaultpage     => 'index.html',
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

  file {'index.html':
    ensure => 'file',
    path   => 'c:\\inetpub\\animal\\index.html',
    source => 'puppet:///site-modules/index.html',
  }

  file {'animal.gif':
    ensure => 'file',
    path   => 'c:\\inetpub\\animal\\animal.gif',
    source => 'puppet:///site-modules/animal.gif',
  }
}