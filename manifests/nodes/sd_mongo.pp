node 'sd_db' {
  Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],}
  exec { "apt-update": command => "apt-get update", }
  package { 'mongodb': 
    ensure => "installed",
    require => Exec["apt-update"],
  }
}

