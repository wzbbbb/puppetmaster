class postfix::params {
  case $::lsbdistcodename {
    'lenny', 'squeeze', 'maverick', 'natty': {
      $email = hiera('email')
      $host  = hiera('host')
    }
    default: {
      fail("Module ${module_name} does not support ${::lsbdistcodename}")
    }
  }
}