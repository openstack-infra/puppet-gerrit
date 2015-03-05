# == Class: gerrit::remotes
#
class gerrit::remotes($ensure=present) {
    class { 'jeepyb::fetch_remotes':
      ensure  => $ensure,
      user    => 'gerrit2',
      minute  => '*/30',
      logfile => '/var/log/gerritfetchremotes.log',
    }

    file { '/var/lib/jeepyb':
      ensure  => directory,
      owner   => 'gerrit2',
      require => User['gerrit2'],
      before  => Class['jeepyb::fetch_remotes'],
    }

    file { '/home/gerrit2/remotes.config':
      ensure => absent,
    }
}
