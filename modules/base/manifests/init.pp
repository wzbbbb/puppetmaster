# == Class: base
#
# Full description of class base here.
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
#  class { base:
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
class base {
  user { 'admin':
    ensure  => 'present',
    gid     => 'admin',
    require => Group['admin'],
    uid     => 2000,
    home    => "/home/admin",
    shell   => "/bin/bash",
    managehome  => true,
  }
  group { 'admin':
    ensure => 'present',
  }
  file { '/home/admin/.ssh':
    ensure => 'directory',
    owner => 'admin',
    group => 'admin',
    mode   => '0700',
  }
  file { '/home/admin/.ssh/id_rsa':
    ensure => 'present',
    owner => 'admin',
    group => 'admin',
    mode   => '0600',
    source => 'puppet:///modules/base/id_rsa',
    require => File['/home/admin/.ssh'],
  }
  file { '/home/admin/.ssh/authorized_keys':
    ensure => 'present',
    owner => 'admin',
    group => 'admin',
    mode   => '0600',
    source => 'puppet:///modules/base/authorized_keys',
    require => File['/home/admin/.ssh'],
  }
  file { '/home/admin/.ssh/known_hosts':
    ensure => 'present',
    owner => 'admin',
    group => 'admin',
    mode   => '0600',
    source => 'puppet:///modules/base/known_hosts',
    require => File['/home/admin/.ssh'],
  }
}

