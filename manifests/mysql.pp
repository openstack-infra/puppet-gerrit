# == Class: gerrit::mysql
#
class gerrit::mysql(
  $mysql_root_password = '',
  $database_name = '',
  $database_user = '',
  $database_password = '',
) {

  $mysql_data = load_module_metadata('mysql', true)
  if $mysql_data == {} {
    warning("An old version of the puppetlabs-mysql module was found on your \
system. The gerrit module only officially supports the latest 3.x version of \
the mysql module.")
    class { '::mysql::server':
      config_hash => {
        'root_password'  => $mysql_root_password,
        'default_engine' => 'InnoDB',
        'bind_address'   => '127.0.0.1',
      }
    }
  } else { # If it has metadata.json, assume it's new enough to use this interface
    class { '::mysql::server':
      root_password    => $mysql_root_password,
      override_options => {
        'mysqld' => {
          'default-storage-engine' => 'InnoDB',
          # Remove NO_ZERO_DATE mode so gerrit can initialize
          'sql-mode'               => 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION',
        }
      },
    }
  }
  include ::mysql::server::account_security

  mysql::db { $database_name:
    user     => $database_user,
    password => $database_password,
    host     => 'localhost',
    grant    => ['all'],
    charset  => 'utf8',
    require  => [
      Class['mysql::server'],
      Class['mysql::server::account_security'],
    ],
  }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
