define postfix::relayhost($host) {
  file { $name:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    alias   => 'main.cf',
    content => template('postfix/common/etc/postfix/main.cf.erb'),
    notify  => Service['postfix'],
    require => Package['postfix'],
  }
}