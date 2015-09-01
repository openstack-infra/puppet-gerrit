# Installing ssl-cert in order to get snakeoil certs
package { 'ssl-cert':
  ensure => present,
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
file { $ssh_key_directory:
  ensure => directory,
}

ssh_keygen {'ssh_rsa_key':
  ssh_directory => $ssh_key_directory,
  require       => File[$ssh_key_directory],
}
ssh_keygen {'ssh_project_rsa_key':
  ssh_directory => $ssh_key_directory,
  require       => File[$ssh_key_directory],
}
ssh_keygen {'ssh_replication_rsa_key':
  ssh_directory => $ssh_key_directory,
  require       => File[$ssh_key_directory],
}
