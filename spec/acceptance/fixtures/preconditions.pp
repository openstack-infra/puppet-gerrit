# workaround since ssl-cert group is not being installed as part of
# this module
package { 'ssl-cert':
  ensure => present,
}

# workaround since pip is not being installed as part of this module
package { 'python-setuptools' :
  ensure => present,
}

exec { 'install pip using easy_install':
  command => 'easy_install -U pip',
  path    => '/bin:/usr/bin:/usr/local/bin',
  require => Exec['python-setuptools'],
}

define create_ssh_key_directory() {
  Exec { path => '/bin:/usr/bin' }
  exec { "create temporary ${name} directory":
    command => "mkdir -p ${name}",
  }
}

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
