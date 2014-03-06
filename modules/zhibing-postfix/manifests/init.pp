# == Class: postfix
#
# Full description of class postfix here.
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
#  class { postfix:
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
class postfix {
  package {'postfix':
    ensure => 'installed' ,
    require=> Exec['apt-update'],
    before => File['/etc/postfix/main.cf'],
  }
  package {'mailutils':  }
  file { '/etc/postfix/main.cf':
    ensure => file,
    mode   => '0644',
    content=> "$::{postfix_config_content}",
  }
  service { 'postfix':
    ensure     => running,
    require    => Package['postfix'],
    enable     => true,
    subscribe  => File['/etc/postfix/main.cf'],
  }

}
