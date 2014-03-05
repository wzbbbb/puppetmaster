class mailutils:{
  package {'mailutils':  
    ensure => "installed" ,
   require => Exec["apt-update"],
  }
}

