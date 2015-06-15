# == Class: gerrit::remotes
#
class gerrit::remotes($ensure=present) {
    file { '/home/gerrit2/remotes.config':
      ensure => absent,
    }
    include jeepyb::fetch_remotes
}
