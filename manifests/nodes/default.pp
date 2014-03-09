node default { #include everything
  notify{'Installation with default node configuration.': }
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],}
  exec { 'apt-update': command => 'apt-get update', }
  include base
  include nginx
  include postfix
  #include sidekiq
  #include unicorn
  include redisserver
  include mongodb
  include git
  include mailutils
  include rubystack
}
