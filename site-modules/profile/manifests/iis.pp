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
    source => 'puppet:///site-modules/profile/index.html',
  }
}
