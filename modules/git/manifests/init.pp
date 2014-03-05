package {'git':
  require => Exec["apt-update"],
  ensure => "installed" ,
}

~

