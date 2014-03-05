package {'rvm': 
  require => Exec["apt-update"],
  provider => 'gem', 
  ensure => "installed" ,
}

