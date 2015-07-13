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
  class { ::httpd::logrotate:
    options => $options
  }
}
