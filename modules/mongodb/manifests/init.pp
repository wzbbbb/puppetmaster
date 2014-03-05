class mongo {
  package { 'mongodb':
    require => Exec["apt-update"],
    ensure => "installed",
  }
  service { 'mognod':
    require => Package['mognodb'],
    #provider   => 'upstart',
    ensure     => running,
    enable     => true,
    #subscribe  => File['nginx.conf'],
  }
}
