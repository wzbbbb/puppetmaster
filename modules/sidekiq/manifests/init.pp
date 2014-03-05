class sidekiq: {
  package {'sidekiq':
    require => Exec["apt-update"],
    ensure => "installed",
    provider => 'gem',
  }
  service {'sidekiq':
    require => Package['sidekiq'],
    ensure => running,
    enable => true,
  }
}

