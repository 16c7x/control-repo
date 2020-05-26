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

  iis_site { 'minimal':
    ensure          => 'started',
    physicalpath    => 'c:\\inetpub\\minimal',
    defaultpage     => 'index.html',
    applicationpool => 'DefaultAppPool',
    require         => [
      File['minimal'],
      Iis_site['Default Web Site']
    ]
  }

  file { 'minimal':
    ensure => 'directory',
    path   => 'c:\\inetpub\\minimal',
  }

  file {'index.html':
    ensure => 'file',
    path   => 'c:\\inetpub\\minimal\\index.html',
    source => 'puppet:///site-modules/index.html',
  }

  file {'animal.gif':
    ensure => 'file',
    path   => 'c:\\inetpub\\minimal\\animal.gif',
    source => 'puppet:///site-modules/animal.gif',
  }
}
