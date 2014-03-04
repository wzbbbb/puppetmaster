node 'raring64.orsypgroup.com' {
  Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],}
  exec { "apt-update": command => "apt-get update", }
  Package { ensure => "installed" }
  package {'nginx': 
   require => Exec["apt-update"],
  }
  package {'rvm': provider => 'gem', }
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
  }
  service { 'puppetmaster': ensure => "stopped",}
# second node
  package {'sidekiq':
    require => Exec["apt-update"],
    provider => 'gem',
  }
  package {'unicorn':
    require => Exec["apt-update"],
    provider => 'gem',
  }
  package {'redis-server':
    require => Exec["apt-update"],
  }
# third node
  package { 'mongodb':
    ensure => "installed",
    require => Exec["apt-update"],
  }
service
}
