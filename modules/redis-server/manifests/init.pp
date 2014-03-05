class redis-server {
  package {'redis-server':
    ensure => "installed",
    require => Exec["apt-update"],
  }
  service {'redis-server':
    require => Package['redis-server'],
    ensure => running,
    enable => true,
  }
}
