class nginx {
  package {'nginx': 
    ensure => "installed" ,
    require => Exec["apt-update"],
  }
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

