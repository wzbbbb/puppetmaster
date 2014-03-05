class unicorn {
  package {'unicorn':
    ensure => "installed",
    require => Exec["apt-update"],
    provider => 'gem',
  }
  service {'unicorn':
    require => Package['unicorn'],
    ensure => running,
    enable => true,
  }
}
