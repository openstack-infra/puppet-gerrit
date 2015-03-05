# == Class: gerrit::remotes
#
class gerrit::remotes($ensure=present) {
    class { 'jeepyb::fetch_remotes':
      ensure  => $ensure,
      user    => 'gerrit2',
      minute  => '*/30',
      req     => [File['/var/lib/jeepyb']],
      logfile => '/var/log/gerritfetchremotes.log',
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
