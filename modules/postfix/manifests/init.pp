class postfix {
  package {'postfix': 
    ensure => "installed" ,
    require => Exec["apt-update"],
    before => File['/etc/postfix/main.cf'],
  }
  package {'mailutils':  }
  file { '/etc/postfix/main.cf':
    ensure => file,
    mode   => 644,
    content => $postfix_config_content,
  }
  service { 'postfix':
    require => Package['postfix'],
    ensure     => running,
    enable     => true,
    subscribe  => File['/etc/postfix/main.cf'],
  }
}

