node default { #include everything
  notify{'Installation with default node configuration.': }
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],}
  exec { 'apt-update': command => 'apt-get update', }
  #include base
  include nginx
  include postfix
  #include rvm
  #rvm_system_ruby {
  #  'ruby-2.1.0':
  #    ensure      => 'present',
  #    default_use => true,
  #    build_opts  => ['--binary'];
  #}
  #include sidekiq
  #include unicorn
  include redisserver
  include mongodb
  include git
  include mailutils
  exec { 'install ruby 2.1.0':
    command => '/usr/local/rvm/bin/rvm install 2.1.0',
    onlyif  => '/usr/local/bin/gem install rvm',
  }
  #exec { 'capistrano script':
  #    command => 'ls',
  #    require => Service['mongod', 'redis-server', 'nginx', 'unicorn', 'sidekiq'],
  #}
}