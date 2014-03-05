Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],}
exec { "apt-update": command => "apt-get update", }
Package { ensure => "installed" ,
  require => Exec["apt-update"],
}
package {'rvm': provider => 'gem', }
package {'git' : }
class nginx {
  package {'nginx': }
  file{ 'nginx.conf':
    require => Package['nginx'],
    path => '/etc/nginx/nginx.conf',
    ensure => file,
    mode   => 644,
    source => "puppet:///$nginx_conf",
  }
  service { 'nginx':
    require => Package['nginx'],
    #provider   => 'upstart',
    ensure     => running,
    enable     => true,
    subscribe  => File['nginx.conf'],
    #start => "/sbin/service nginx start",
    #stop => "/sbin/service nginx stop",
    #status => "/sbin/serv",

  }
}
class postfix {
  package {'postfix': before => File['/etc/postfix/main.cf'] }
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

