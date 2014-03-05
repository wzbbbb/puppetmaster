class mongo {
  package { 'mongodb':
    require => Exec["apt-update"],
    ensure => "installed",
  }
  service { 'mognodb':
    require => Package['mognodb'],
    #provider   => 'upstart',
    ensure     => running,
    enable     => true,
    #subscribe  => File['nginx.conf'],
  }
}
