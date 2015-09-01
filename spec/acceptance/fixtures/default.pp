class { '::gerrit::mysql':
  mysql_root_password => 'UNSET',
  database_name       => 'reviewdb',
  database_user       => 'gerrit2',
  database_password   => '12345',
}

class { '::gerrit':
  mysql_host                          => 'localhost',
  mysql_password                      => '12345',
  war                                 => 'http://tarballs.openstack.org/ci/gerrit/gerrit-v2.8.4.19.4548330.war',
  ssh_rsa_key_contents                => file('/tmp/gerrit-ssh-keys/ssh_rsa_key'),
  ssh_rsa_pubkey_contents             => file('/tmp/gerrit-ssh-keys/ssh_rsa_key.pub'),
  ssh_project_rsa_key_contents        => file('/tmp/gerrit-ssh-keys/ssh_project_rsa_key'),
  ssh_project_rsa_pubkey_contents     => file('/tmp/gerrit-ssh-keys/ssh_project_rsa_key.pub'),
  ssh_replication_rsa_key_contents    => file('/tmp/gerrit-ssh-keys/ssh_replication_rsa_key'),
  ssh_replication_rsa_pubkey_contents => file('/tmp/gerrit-ssh-keys/ssh_replication_rsa_key.pub'),
  secondary_index                     => true,
  secondary_index_type                => 'LUCENE',
}

class { '::gerrit::cron': }
