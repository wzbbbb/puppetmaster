node 'raring64.orsypgroup.com' {
  file { "/tmp/test.txt":
   ensure => file,
   content => "it works",
  }
  file { "/tmp/install.sh":
   mode => 755,
   owner => root,
   group => root,
   source => "puppet:///${install_script}" , 
  }
  exec { 'package update':
   command => "/tmp/install.sh",
   require =>File["/tmp/install.sh"],
  }

  package {'postfix':
    ensure => present,
    before => File['/etc/postfix/main.cf']

  }
  file { '/etc/postfix/main.cf':
    ensure => file,
    mode   => 644,
    content => $postfix_config_content,
  }
  service { 'postfix':
    ensure     => running,
    enable     => true,
    subscribe  => File['/etc/postfix/main.cf'],
  }
  package {'mailutils':
    ensure => present,
  }

  file{ '/etc/nginx/nginx.conf':
    ensure => file,
    mode   => 644,
    source => "puppet:///$nginx_conf", # pulled from git
    require => Exec['package update'],
  }
  service { 'nginx':
    ensure     => running,
    enable     => true,
    subscribe  => File['/etc/nginx/nginx.conf'],
    require => Exec['package update'],
  }
}

