# workaround since ssl-cert group is not being installed as part of
# this module
package { 'ssl-cert':
  ensure => present,
}

exec { 'ensure ssl-cert exists':
  command => '/usr/sbin/groupadd -f ssl-cert',
  unless  => '/bin/grep ssl-cert /etc/group',
}

# workaround since pip is not being installed as part of this module
package { 'python-pip':
  ensure => present,
}

class { '::gerrit::mysql':
  mysql_root_password => 'UNSET',
  database_name       => 'reviewdb',
  database_user       => 'gerrit2',
  database_password   => '12345',
  before              => Class['::gerrit'],
}

# The mysql module doesn't restart the mysql service by default,
# and since mysql is preinstalled by bindep, the service is already
# started when the config is applied. This triggers a restart so that the
# sql-mode can be applied.
Class['::mysql::server::config'] ~> Class['::mysql::server::service']

class { '::gerrit':
  mysql_host                          => 'localhost',
  mysql_password                      => '12345',
  war                                 => 'http://tarballs.openstack.org/ci/test/gerrit-v2.11.4.13.cb9800e.war',
  vhost_name                          => 'localhost',
  canonical_git_url                   => 'localhost',
  ssh_rsa_key_contents                => file('/tmp/gerrit-ssh-keys/ssh_rsa_key'),
  ssh_rsa_pubkey_contents             => file('/tmp/gerrit-ssh-keys/ssh_rsa_key.pub'),
  ssh_project_rsa_key_contents        => file('/tmp/gerrit-ssh-keys/ssh_project_rsa_key'),
  ssh_project_rsa_pubkey_contents     => file('/tmp/gerrit-ssh-keys/ssh_project_rsa_key.pub'),
  ssh_replication_rsa_key_contents    => file('/tmp/gerrit-ssh-keys/ssh_replication_rsa_key'),
  ssh_replication_rsa_pubkey_contents => file('/tmp/gerrit-ssh-keys/ssh_replication_rsa_key.pub'),
  secondary_index                     => true,
  secondary_index_type                => 'LUCENE',
  offline_reindex                     => true,
  commitmessage_params                =>
    {
      maxSubjectLength   => '60',
      maxLineLength      => '72',
      longLinesThreshold => '20',
      rejectTooLong      => 'true',
    },
  its_plugins                         => [
    {
      'name'          => 'its-storyboard',
      'password'      => 'secret_token',
      'url'           => 'https://storyboard.openstack.org',
    },
  ],
  its_rules                           => [
    {
      'name'          => 'change_updates',
      'event_type'    => 'patchset-created',
      'action'        => 'add-standard-comment',
      label           => [
        {
          'name'      => 'approval-Code-Review',
          'approvals' => '-2, -1',
        },
      ],
     },
   ],
}

class { '::gerrit::cron': }
