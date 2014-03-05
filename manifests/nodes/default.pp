node default { #include everything
  notify{"Installation with default node configuration.": }
  Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],}
  exec { "apt-update": command => "apt-get update", }
  include nginx,
  include postfix,
  include rvm,
  include sidekiq,
  include unicorn,
  include redis-server,
  include mongodb,
  include git,
  include mailutils,
  exec { "capistrano script":
      command => "ls",
      require => Service['mongod'],
      require => Service['redis-server'],
      require => Service['nginx']
      require => Service['unicorn']
      require => Service['sidekiq'],
  }

}
