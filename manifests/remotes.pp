# == Class: gerrit::remotes
#
class gerrit::remotes($ensure=present) {
    file { '/home/gerrit2/remotes.config':
      ensure => absent,
    }
    class { '::jeepyb::fetch_remotes':
      ensure => $ensure,
    }
}
