# == Class: gerrit::remotes
#
class gerrit::remotes($ensure=present) {
    cron { 'gerritfetchremotes':
      ensure  => $ensure,
      user    => 'gerrit2',
      minute  => '*/30',
      command => 'sleep $((RANDOM\%60+90)) && /usr/local/bin/manage-projects -v >> /var/log/manage_projects.log 2>&1',
      require => [Class['jeepyb'], File['/var/lib/jeepyb']],
    }

    file { '/var/lib/jeepyb':
      ensure  => directory,
      owner   => 'gerrit2',
      require => User['gerrit2'],
    }

    file { '/home/gerrit2/remotes.config':
      ensure => absent,
    }
}
