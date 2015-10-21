# == Class: gerrit::cron
#
class gerrit::cron (
  $replicate_local = true,
  $replicate_path = '/opt/lib/git',
) {

  cron { 'gerrit_repack':
    user        => 'gerrit2',
    weekday     => '0',
    hour        => '4',
    minute      => '7',
    command     => 'find /home/gerrit2/review_site/git/ -type d -name "*.git" -print -exec git --git-dir="{}" repack -afd \;',
    environment => 'PATH=/usr/bin:/bin:/usr/sbin:/sbin',
  }

  # if local replication is enabled, repack this mirror as well
  if $replicate_local {
    cron { 'mirror_repack_local':
      user        => 'gerrit2',
      weekday     => '0',
      hour        => '4',
      minute      => '17',
      command     => "find ${replicate_path} -type d -name \"*.git\" -print -exec git --git-dir=\"{}\" repack -afd \\;",
      environment => 'PATH=/usr/bin:/bin:/usr/sbin:/sbin',
    }
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
