# == Class: gerrit::remotes
#
class gerrit::remotes($ensure=present) {
    file { '/home/gerrit2/remotes.config':
      ensure => absent,
    }
    jeepyb::fetch_remotes {
      ensure => $ensure,
    }
}
