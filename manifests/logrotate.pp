# == Class: gerrit::logrotate
#
class gerrit::logrotate(
  $options = [
      'daily',
      'missingok',
      'rotate 30',
      'compress',
      'delaycompress',
      'notifempty',
      'create 640 root adm',
      'sharedscripts',
  ]
) {
  include ::logrotate

  if $::osfamily  == 'RedHat' {
    $apache_logdir = '/var/log/httpd'
  }
  else {
    $apache_logdir = '/var/log/apache2'
  }
  ::logrotate::file { "${apache_logdir}/gerrit_apache2":
    log     => "${apache_logdir}/*.log",
    options => $options,
  }
}
