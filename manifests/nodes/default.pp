node default { #include everything
  notify{'Installation with default node configuration.': }
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],}
  #exec { 'apt-update': command => 'apt-get update', }
  #include base
  #include nginx
  #include postfix
  #include rvm
  #rvm_system_ruby {
  #  'ruby-2.1.0':
  #    ensure      => 'present',
  #    default_use => true,
  #    build_opts  => ['--binary'];
  #}
  #include sidekiq
  #include unicorn
  #include redisserver
  #include mongodb
  #include git
  #include mailutils
  #exec { 'install ruby 2.1.0':
  #  command => 'su admin -c " /home/admin/.rvm/bin/rvm install 2.1.0"',
  #  onlyif  => 'su admin -c "\curl -sSL https://get.rvm.io | bash -s stable"',
  #  timeout => 1800,
  #  require => User['admin']
  #}
  exec { 'capistrano script':
      command => 'su admin -c "cd ~/server; rvm 2.1.0 do cap local deploy"',
      onlyif  =>[ 'su admin -c "cd ~; git clone -b develop git@192.168.114.174:smoke-detector/server.git"',
                  'su admin -c "cd ~/server; rvm 2.1.0 do gem install bundler"',
                  'su admin -c "cd ~/server; rvm 2.1.0 do bundle install"'],
      timeout => 1800,
      #require => Service['mongod', 'redis-server', 'nginx'],
      require => Exec['install ruby 2.1.0'],

  }
}
