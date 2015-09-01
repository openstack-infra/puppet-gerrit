# workaround since ssl-cert group is not being installed as part of
# this module
package { 'ssl-cert':
  ensure => present,
}

# workaround since pip is not being installed as part of this module
exec { 'download get-pip.py':
  command => 'wget https://bootstrap.pypa.io/get-pip.py -O /tmp/get-pip.py',
  path    => '/bin:/usr/bin:/usr/local/bin',
  creates => '/tmp/get-pip.py',
}

exec { 'install pip using get-pip':
  command     => 'python /tmp/get-pip.py',
  path        => '/bin:/usr/bin:/usr/local/bin',
  refreshonly => true,
  subscribe   => Exec['download get-pip.py'],
}

# method to create ssh directory
define create_ssh_key_directory() {
  Exec { path => '/bin:/usr/bin' }
  exec { "create temporary ${name} directory":
    command => "mkdir -p ${name}",
  }
}

# method to generate key
define ssh_keygen (
  $ssh_directory = undef
) {
  Exec { path => '/bin:/usr/bin' }

  $ssh_key_file = "${ssh_directory}/${name}"

  exec { "ssh-keygen for ${name}":
    command => "ssh-keygen -t rsa -f ${ssh_key_file} -N ''",
    creates => $ssh_key_file,
  }
}

$ssh_key_directory = '/tmp/gerrit-ssh-keys'
create_ssh_key_directory { $ssh_key_directory: }
ssh_keygen {'ssh_rsa_key': ssh_directory => $ssh_key_directory }
ssh_keygen {'ssh_project_rsa_key': ssh_directory => $ssh_key_directory }
ssh_keygen {'ssh_replication_rsa_key': ssh_directory => $ssh_key_directory }
