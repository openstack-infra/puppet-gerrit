# == Class: gerrit::cron
#
class gerrit::cron (
    $local_git_dir = '/home/gerrit2/review_site/git/',
) {

  cron { 'gerrit_repack':
    user        => 'gerrit2',
    weekday     => '0',
    hour        => '4',
    minute      => '7',
    command     => "find ${local_git_dir} -type d -name \"*.git\" -print -exec git --git-dir=\"{}\" repack -afd \\;",
    environment => 'PATH=/usr/bin:/bin:/usr/sbin:/sbin',
  }

  cron { 'expireoldreviews':
    ensure => 'absent',
    user   => 'gerrit2',
  }

  cron { 'removedbdumps':
    ensure => 'absent',
    user   => 'gerrit2',
  }

  cron { 'clear_gerrit_logs':
    # Gerrit rotates their own logs, but doesn't clean them out
    # Delete logs older than a month
    user        => 'gerrit2',
    hour        => '6',
    minute      => '1',
    command     => 'find /home/gerrit2/review_site/logs/*.gz -mtime +30 -exec rm -f {} \;',
    environment => 'PATH=/usr/bin:/bin:/usr/sbin:/sbin',
  }
}
