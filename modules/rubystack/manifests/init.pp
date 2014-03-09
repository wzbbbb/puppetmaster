# == Class: rubystack
#
# Full description of class rubystack here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { rubystack:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class rubystack {
  exec { 'install ruby 2.1.0':
    command => 'su admin -c " /home/admin/.rvm/bin/rvm install 2.1.0"',
    onlyif  => 'su admin -c "\curl -sSL https://get.rvm.io | bash -s stable"',
    timeout => 1800,
    require => User['admin'],
  }
  exec { 'clone repo':
    command =>'su admin -c "cd ~; git clone -b develop git@192.168.114.174:smoke-detector/server.git"',
    require => [File['/home/admin/.ssh/id_rsa',
                    '/home/admin/.ssh/authorized_keys',
                    '/home/admin/.ssh/known_hosts'],
                Exec['install ruby 2.1.0']],
    timeout => 1800,
  }
  exec { 'bundle install':
    command=> 'su admin -c "cd ~/server; /home/admin/.rvm/bin/rvm 2.1.0 do bundle install"',
    onlyif => 'su admin -c "cd ~/server; /home/admin/.rvm/bin/rvm 2.1.0 do gem install bundler"',
    timeout=> 1800,
    require=> Exec['clone repo'],
  }
  exec { 'capistrano script':
    command => 'su admin -c "cd ~/server; /home/admin/.rvm/bin/rvm 2.1.0 do cap local deploy"',
    timeout => 1800,
    require => Exec['bundle install'],
  }
}


