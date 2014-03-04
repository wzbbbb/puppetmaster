node 'sd_queue' {
  Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],}
  exec { "apt-update": command => "apt-get update", }
  Package { ensure => "installed" }
  package {'sidekiq':
    require => Exec["apt-update"],
    provider => 'gem',
  }
  package {'unicorn':
    require => Exec["apt-update"],
    provider => 'gem',
  }
  package {'redis-server':
    require => Exec["apt-update"],
  }
}

