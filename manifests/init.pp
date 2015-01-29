# Install and maintain Gerrit Code Review.
# params:
#   mysql_host:
#     The mysql host to which gerrit should connect.
#   mysql_password:
#     The password with which gerrit connects to mysql.
#   vhost_name:
#     used in the Apache virtual host, eg., review.example.com
#   canonicalweburl:
#     Used in the Gerrit config to generate links,
#       eg., https://review.example.com/
#   ssl_cert_file:
#   ssl_key_file:
#     Used in the Apache virtual host to specify the SSL cert and key files.
#   ssl_chain_file:
#     Optional, if you have an intermediate cert Apache should serve.
#   ssl_*_file_contents:
#     Optional, the contents of the respective cert files as a string. Will be
#     used to have Puppet ensure the contents of these files. Default value of
#     '' means Puppet should not manage these files.
#   openidssourl:
#     The URL to use for OpenID in SSO mode.
#   email:
#     The email address Gerrit should use when sending mail.
#   smtpserver:
#     The smtp server that Gerrit should send mail through.
#   sendemail_from:
#     gerrit.conf value for sendemail.from.
#   database_poollimit:
#   container_heaplimit:
#   core_packedgitopenfiles:
#   core_packedgitlimit:
#   core_packedgitwindowsize:
#   sshd_threads:
#   sshd_listen_address:
#   httpd_acceptorthreads:
#   httpd_minthreads:
#   httpd_maxthreads:
#   httpd_maxwait:
#     Gerrit configuration options; see Gerrit docs.
#   commentlinks:
#     A list of regexes Gerrit should hyperlink.
#   trackingids:
#     A list of regexes to reference external tracking systems.
#   war:
#     The URL of the Gerrit WAR that should be downloaded and installed.
#     Note that only the final component is used for comparing to the most
#     recently installed WAR.  In other words, if you update the war from:
#
#       http://tarballs.openstack.org/ci/gerrit.war
#     to:
#       http://somewhereelse.example.com/gerrit.war
#
#     Gerrit won't be updated unless you delete gerrit.war from
#     ~gerrit2/gerrit-wars.  But if you change the URL from:
#
#       http://tarballs.openstack.org/ci/gerrit-2.2.2.war
#     to:
#       http://tarballs.openstack.org/ci/gerrit-2.3.0.war
#     Gerrit will be upgraded on the next puppet run.
#   contactstore:
#     A boolean enabling the contact store feature
#   contactstore_appsec:
#     An application shared secret for the contact store protocol
#   contactstore_pubkey:
#     A public key with which to encrypt contact information
#   contactstore_url:
#     A URL for the remote contact store application
#   replicate_local:
#     A boolean enabling local replication for apache acceleration
#   replicate_path:
#     The path to the local git replica if replicate_local is enabled
#   gitweb:
#     A boolean enabling gitweb
#   cgit:
#     A boolean enabling cgit
#   web_repo_url:
#     Url for setting the location of an external git browser
#   testmode:
#     Set this to true to disable cron jobs and replication,
#     which can interfere with testing.
#   secondary_index:
#     Set this to true to enable secondary index support
#   secondary_index_type:
#     which secondary index to use: SQL (no secondary index),
#     LUCENE (recommended), SOLR (experimental). Note: as of
#     Gerrit 2.9 LUCENE is default secondary index and SQL is
#     removed.
# TODO: make more gerrit options configurable here
#
class gerrit(
  $mysql_host = 'localhost',
  $mysql_password,
  $war = '',
  $email_private_key = '',
  $vhost_name = $::fqdn,
  $canonicalweburl = "https://${::fqdn}/",
  $robots_txt_source = '', # If left empty, the gerrit default will be used.
  $serveradmin = "webmaster@${::fqdn}",
  $ssl_cert_file = '/etc/ssl/certs/ssl-cert-snakeoil.pem',
  $ssl_key_file = '/etc/ssl/private/ssl-cert-snakeoil.key',
  $ssl_chain_file = '',
  $ssl_cert_file_contents = '', # If left empty puppet will not create file.
  $ssl_key_file_contents = '', # If left empty puppet will not create file.
  $ssl_chain_file_contents = '', # If left empty puppet will not create file.
  $ssh_dsa_key_contents = '', # If left empty puppet will not create file.
  $ssh_dsa_pubkey_contents = '', # If left empty puppet will not create file.
  $ssh_rsa_key_contents = '', # If left empty puppet will not create file.
  $ssh_rsa_pubkey_contents = '', # If left empty puppet will not create file.
  $ssh_project_rsa_key_contents = '', # If left empty will not create file.
  $ssh_project_rsa_pubkey_contents = '', # If left empty will not create file.
  $ssh_replication_rsa_key_contents = '', # If left emptry will not create files.
  $ssh_replication_rsa_pubkey_contents = '', # If left emptry will not create files.
  $gerrit_auth_type = 'OPENID_SSO',
  $gerrit_contributor_agreement = true,
  $openidssourl = 'https://login.launchpad.net/+openid',
  $ldap_server = '',
  $ldap_account_base = '',
  $ldap_username = '',
  $ldap_password = '',
  $ldap_account_pattern = '',
  $ldap_account_email_address = '',
  $ldap_sslverify = true,
  $ldap_ssh_account_name = '',
  $ldap_accountfullname = '',
  $email = '',
  $smtpserver = 'localhost',
  $sendemail_from = 'MIXED',
  $database_poollimit = '',
  $container_heaplimit = '',
  $core_packedgitopenfiles = '',
  $core_packedgitlimit = '',
  $core_packedgitwindowsize = '',
  $sshd_threads = '',
  $sshd_listen_address = '*:29418',
  $httpd_acceptorthreads = '',
  $httpd_minthreads = '',
  $httpd_maxthreads = '',
  $httpd_maxwait = '',
  $commentlinks = [],
  $trackingids = [],
  $contactstore = false,
  $contactstore_appsec = '',
  $contactstore_pubkey = '',
  $contactstore_url = '',
  $enable_melody = false,
  $melody_session = false,
  $replicate_local = false,
  $replicate_path = '/opt/lib/git',
  $replication = [],
  $gitweb = true,
  $cgit = false,
  $web_repo_url = '',
  $testmode = false,
  $secondary_index = false,
  $secondary_index_type = 'LUCENE',
  $enable_javamelody_top_menu = false,
) {
  include apache
  include jeepyb
  include pip

  $java_home = $::lsbdistcodename ? {
    'precise' => '/usr/lib/jvm/java-7-openjdk-amd64/jre',
  }

  $gerrit_war = '/home/gerrit2/review_site/bin/gerrit.war'
  $gerrit_site = '/home/gerrit2/review_site'

  include gerrit::user

  if ($gitweb) {
    package { 'gitweb':
      ensure => present,
    }
  }

  package { 'unzip':
    ensure => present,
  }

  package { 'openjdk-7-jre-headless':
    ensure => present,
  }

  package { 'openjdk-6-jre-headless':
    ensure  => purged,
    require => Package['openjdk-7-jre-headless'],
  }

  file { '/var/log/gerrit':
    ensure => directory,
    owner  => 'gerrit2',
  }

  if ((!defined(File['/opt/lib']))
      and ($replicate_path =~ /^\/opt\/lib\/.*$/)) {
    file { '/opt/lib':
      ensure => directory,
      owner  => root,
    }
  }

  # Prepare gerrit directories.  Even though some of these would be created
  # by the init command, we can go ahead and create them now and populate them.
  # That way the config files are already in place before init runs.

  file { '/home/gerrit2/review_site':
    ensure  => directory,
    owner   => 'gerrit2',
    require => User['gerrit2'],
  }

  file { '/home/gerrit2/review_site/plugins':
    ensure  => directory,
    owner   => 'gerrit2',
    require => [User['gerrit2'], File['/home/gerrit2/review_site']],
  }

  file { '/home/gerrit2/.ssh':
    ensure  => directory,
    owner   => 'gerrit2',
    mode    => '0700',
    require => User['gerrit2'],
  }

  file { '/home/gerrit2/review_site/etc':
    ensure  => directory,
    owner   => 'gerrit2',
    require => File['/home/gerrit2/review_site'],
  }

  file { '/home/gerrit2/review_site/bin':
    ensure  => directory,
    owner   => 'gerrit2',
    require => File['/home/gerrit2/review_site'],
  }

  file { '/home/gerrit2/review_site/static':
    ensure  => directory,
    owner   => 'gerrit2',
    require => File['/home/gerrit2/review_site'],
  }

  file { '/home/gerrit2/review_site/hooks':
    ensure  => directory,
    owner   => 'gerrit2',
    require => File['/home/gerrit2/review_site'],
  }

  file { '/home/gerrit2/review_site/lib':
    ensure  => directory,
    owner   => 'gerrit2',
    require => File['/home/gerrit2/review_site'],
  }

  # Skip replication if we're in test mode
  if ($testmode == false) {
    # Template uses $replication
    file { '/home/gerrit2/review_site/etc/replication.config':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      content => template('gerrit/replication.config.erb'),
      replace => true,
      require => File['/home/gerrit2/review_site/etc'],
    }
  }

  # Gerrit sets these permissions in 'init'; don't fight them.
  # Template uses:
  # - $mysql_host
  # - $canonicalweburl
  # - $database_poollimit
  # - $gerrit_contributor_agreement
  # - $gerrit_auth_type
  # - $openidssourl
  # - $ldap_server
  # - $ldap_username
  # - $ldap_password
  # - $ldap_account_base
  # - $ldap_account_pattern
  # - $ldap_account_email_address
  # - $smtpserver
  # - $sendmail_from
  # - $java_home
  # - $container_heaplimit
  # - $core_packedgitopenfiles
  # - $core_packedgitlimit
  # - $core_packedgitwindowsize
  # - $sshd_listen_address
  # - $sshd_threads
  # - $httpd_maxwait
  # - $httpd_acceptorthreads
  # - $httpd_minthreads
  # - $httpd_maxthreads
  # - $commentlinks
  # - $trackingids
  # - $enable_melody
  # - $melody_session
  # - $gitweb
  # - $contactstore_appsec
  # - $contactstore_url
  file { '/home/gerrit2/review_site/etc/gerrit.config':
    ensure  => present,
    owner   => 'gerrit2',
    group   => 'gerrit2',
    mode    => '0644',
    content => template('gerrit/gerrit.config.erb'),
    replace => true,
    require => File['/home/gerrit2/review_site/etc'],
  }

  # Secret files.

  # Gerrit sets these permissions in 'init'; don't fight them.  If
  # these permissions aren't set correctly, gerrit init will write a
  # new secure.config file and lose the mysql password.
  # Template uses $mysql_password, $email_private_key
  file { '/home/gerrit2/review_site/etc/secure.config':
    ensure  => present,
    owner   => 'gerrit2',
    group   => 'gerrit2',
    mode    => '0600',
    content => template('gerrit/secure.config.erb'),
    replace => true,
    require => File['/home/gerrit2/review_site/etc'],
  }

  # Set up apache.

  # Template uses:
  # - $vhost_name
  # - $serveradmin
  # - $ssl_cert_file
  # - $ssl_key_file
  # - $ssl_chain_file
  # - $canonicalweburl
  # - $replicate_local
  # - $replicate_path
  # - $contactstore
  # - $robots_txt_source
  apache::vhost { $vhost_name:
    port     => 443,
    docroot  => 'MEANINGLESS ARGUMENT',
    priority => '50',
    template => 'gerrit/gerrit.vhost.erb',
    ssl      => true,
  }
  a2mod { 'rewrite':
    ensure => present,
  }
  a2mod { 'proxy':
    ensure => present,
  }
  a2mod { 'proxy_http':
    ensure => present,
  }

  if $ssl_cert_file_contents != '' {
    file { $ssl_cert_file:
      owner   => 'root',
      group   => 'root',
      mode    => '0640',
      content => $ssl_cert_file_contents,
      before  => Apache::Vhost[$vhost_name],
    }
  }

  if $ssl_key_file_contents != '' {
    file { $ssl_key_file:
      owner   => 'root',
      group   => 'ssl-cert',
      mode    => '0640',
      content => $ssl_key_file_contents,
      before  => Apache::Vhost[$vhost_name],
    }
  }

  if $ssl_chain_file_contents != '' {
    file { $ssl_chain_file:
      owner   => 'root',
      group   => 'root',
      mode    => '0640',
      content => $ssl_chain_file_contents,
      before  => Apache::Vhost[$vhost_name],
    }
  }

  if $robots_txt_source != '' {
    file { '/home/gerrit2/review_site/static/robots.txt':
      owner    => 'root',
      group    => 'root',
      mode     => '0444',
      source   => $robots_txt_source,
      require  => File['/home/gerrit2/review_site/static'],
    }
  }

  if $ssh_dsa_key_contents != '' {
    file { '/home/gerrit2/review_site/etc/ssh_host_dsa_key':
      owner   => 'gerrit2',
      group   => 'gerrit2',
      mode    => '0600',
      content => $ssh_dsa_key_contents,
      replace => true,
      require => File['/home/gerrit2/review_site/etc']
    }
  }

  if $ssh_dsa_pubkey_contents != '' {
    file { '/home/gerrit2/review_site/etc/ssh_host_dsa_key.pub':
      owner   => 'gerrit2',
      group   => 'gerrit2',
      mode    => '0644',
      content => $ssh_dsa_pubkey_contents,
      replace => true,
      require => File['/home/gerrit2/review_site/etc']
    }
  }

  if $ssh_rsa_key_contents != '' {
    file { '/home/gerrit2/review_site/etc/ssh_host_rsa_key':
      owner   => 'gerrit2',
      group   => 'gerrit2',
      mode    => '0600',
      content => $ssh_rsa_key_contents,
      replace => true,
      require => File['/home/gerrit2/review_site/etc']
    }
  }

  if $ssh_rsa_pubkey_contents != '' {
    file { '/home/gerrit2/review_site/etc/ssh_host_rsa_key.pub':
      owner   => 'gerrit2',
      group   => 'gerrit2',
      mode    => '0644',
      content => $ssh_rsa_pubkey_contents,
      replace => true,
      require => File['/home/gerrit2/review_site/etc']
    }
  }

  if $ssh_project_rsa_key_contents != '' {
    file { '/home/gerrit2/review_site/etc/ssh_project_rsa_key':
      owner   => 'gerrit2',
      group   => 'gerrit2',
      mode    => '0600',
      content => $ssh_project_rsa_key_contents,
      replace => true,
      require => File['/home/gerrit2/review_site/etc']
    }
  }

  if $ssh_project_rsa_pubkey_contents != '' {
    file { '/home/gerrit2/review_site/etc/ssh_project_rsa_key.pub':
      owner   => 'gerrit2',
      group   => 'gerrit2',
      mode    => '0644',
      content => $ssh_project_rsa_pubkey_contents,
      replace => true,
      require => File['/home/gerrit2/review_site/etc']
    }
  }

  if $ssh_replication_rsa_key_contents != '' {
    file { '/home/gerrit2/.ssh/id_rsa':
      owner   => 'gerrit2',
      group   => 'gerrit2',
      mode    => '0600',
      content => $ssh_replication_rsa_key_contents,
      replace => true,
      require => File['/home/gerrit2/.ssh']
    }
  }

  if $ssh_replication_rsa_pubkey_contents != '' {
    file { '/home/gerrit2/id_rsa.pub':
      owner   => 'gerrit2',
      group   => 'gerrit2',
      mode    => '0644',
      content => $ssh_replication_rsa_pubkey_contents,
      replace => true,
      require => File['/home/gerrit2/.ssh']
    }
  }

  # Install Gerrit itself.

  # The Gerrit WAR is specified as a url like
  #   'http://tarballs.openstack.org/ci/gerrit-2.2.2-363-gd0a67ce.war'
  # Set $basewar so that we can work with filenames like
  #   gerrit-2.2.2-363-gd0a67ce.war'.

  if $war =~ /.*\/(.*)/ {
    $basewar = $1
  } else {
    $basewar = $war
  }

  # This directory is used to download and cache gerrit war files.
  # That way the download and install steps are kept separate.
  file { '/home/gerrit2/gerrit-wars':
    ensure  => directory,
    require => User['gerrit2'],
  }

  # If we don't already have the specified WAR, download it.
  exec { "download:${war}":
    command => "/usr/bin/wget ${war} -O /home/gerrit2/gerrit-wars/${basewar}",
    creates => "/home/gerrit2/gerrit-wars/${basewar}",
    require => File['/home/gerrit2/gerrit-wars'],
  }

  # If gerrit.war isn't the same as $basewar, install it.
  file { $gerrit_war:
    ensure  => present,
    source  => "file:///home/gerrit2/gerrit-wars/${basewar}",
    require => Exec["download:${war}"],
    replace => true,
    # user, group, and mode have to be set this way to avoid retriggering
    # gerrit-init on every run because gerrit init sets them this way
    owner   => 'gerrit2',
    group   => 'gerrit2',
    mode    => '0644',
  }


  # If gerrit.war was just installed, run the Gerrit "init" command.
  exec { 'gerrit-initial-init':
    user        => 'gerrit2',
    command     => "/usr/bin/java -jar ${gerrit_war} init -d ${gerrit_site} --batch --no-auto-start; /usr/bin/java -jar ${gerrit_war} reindex -d ${gerrit_site}",
    subscribe   => File['/home/gerrit2/review_site/bin/gerrit.war'],
    refreshonly => true,
    require     => [Package['openjdk-7-jre-headless'],
                    User['gerrit2'],
                    File['/home/gerrit2/review_site/etc/gerrit.config'],
                    File['/home/gerrit2/review_site/etc/secure.config']],
    notify      => Exec['install-core-plugins'],
    unless      => '/usr/bin/test -f /etc/init.d/gerrit',
    logoutput   => true,
  }

  # If a new gerrit.war was just installed, run the Gerrit "init" command.
  # Stop is included here because it may not be running or the init
  # script may not exist, and in those cases, we don't care if it fails.
  # Running the init script as the gerrit2 user _does_ work.
  exec { 'gerrit-init':
    user        => 'gerrit2',
    command     => "/etc/init.d/gerrit stop; /usr/bin/java -jar ${gerrit_war} init -d ${gerrit_site} --batch --no-auto-start; /usr/bin/java -jar ${gerrit_war} reindex -d ${gerrit_site}",
    subscribe   => File['/home/gerrit2/review_site/bin/gerrit.war'],
    refreshonly => true,
    require     => [Package['openjdk-7-jre-headless'],
                    User['gerrit2'],
                    File['/home/gerrit2/review_site/etc/gerrit.config'],
                    File['/home/gerrit2/review_site/etc/secure.config']],
    notify      => Exec['install-core-plugins'],
    onlyif      => '/usr/bin/test -f /etc/init.d/gerrit',
    logoutput   => true,
  }

  # Install Core Plugins
  exec { 'install-core-plugins':
    user        => 'gerrit2',
    command     => '/usr/bin/unzip -jo /home/gerrit2/review_site/bin/gerrit.war WEB-INF/plugins/* -d /home/gerrit2/review_site/plugins || true',
    subscribe   => File['/home/gerrit2/review_site/bin/gerrit.war'],
    require     => [Package['unzip'],
                    File['/home/gerrit2/review_site/plugins']],
    notify      => Exec['gerrit-start'],
    refreshonly => true,
    logoutput   => true,
  }

  # Symlink the init script.
  file { '/etc/init.d/gerrit':
    ensure  => link,
    target  => '/home/gerrit2/review_site/bin/gerrit.sh',
    require => Exec['gerrit-initial-init'],
  }

  # The init script requires the path to gerrit to be set.
  file { '/etc/default/gerritcodereview':
    ensure  => present,
    source  => 'puppet:///modules/gerrit/gerritcodereview.default',
    replace => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
  }

  # Make sure the init script starts on boot.
  file { ['/etc/rc0.d/K10gerrit',
          '/etc/rc1.d/K10gerrit',
          '/etc/rc2.d/S90gerrit',
          '/etc/rc3.d/S90gerrit',
          '/etc/rc4.d/S90gerrit',
          '/etc/rc5.d/S90gerrit',
          '/etc/rc6.d/K10gerrit']:
    ensure  => link,
    target  => '/etc/init.d/gerrit',
    require => File['/etc/init.d/gerrit'],
  }

  exec { 'gerrit-start':
    command     => '/etc/init.d/gerrit start',
    require     => File['/etc/init.d/gerrit'],
    refreshonly => true,
  }

  file { '/usr/local/gerrit':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/usr/local/gerrit/scripts':
    ensure  => absent,
  }

  package { 'libmysql-java':
    ensure => present,
  }
  file { '/home/gerrit2/review_site/lib/mysql-connector-java.jar':
    ensure  => link,
    target  => '/usr/share/java/mysql-connector-java.jar',
    require => [
      Package['libmysql-java'],
      File['/home/gerrit2/review_site/lib'],
    ],
  }

  package { 'libbcprov-java':
    ensure => present,
  }
  file { '/home/gerrit2/review_site/lib/bcprov.jar':
    ensure  => link,
    target  => '/usr/share/java/bcprov.jar',
    require => [
      Package['libbcprov-java'],
      File['/home/gerrit2/review_site/lib'],
    ],
  }

  # Install Bouncy Castle's OpenPGP plugin and populate the contact store
  # public key file if we're using that feature.
  if ($contactstore == true) {
    package { 'libbcpg-java':
      ensure => present,
    }
    file { '/home/gerrit2/review_site/lib/bcpg.jar':
      ensure  => link,
      target  => '/usr/share/java/bcpg.jar',
      require => [
        Package['libbcpg-java'],
        File['/home/gerrit2/review_site/lib'],
      ],
    }
    # Package is required for Gerrit 2.9.x
    package { 'libbcpkix-java':
      ensure => present,
    }
    file { '/home/gerrit2/review_site/lib/bcpkix.jar':
      ensure  => link,
      target  => '/usr/share/java/bcpkix.jar',
      require => [
        Package['libbcpkix-java'],
        File['/home/gerrit2/review_site/lib'],
      ],
    }
    # Template uses $contactstore_pubkey
    file { '/home/gerrit2/review_site/etc/contact_information.pub':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      content => template('gerrit/contact_information.pub.erb'),
      replace => true,
      require => File['/home/gerrit2/review_site/etc'],
    }
    file { '/home/gerrit2/review_site/lib/fakestore.cgi':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0555',
      source  => 'puppet:///modules/gerrit/fakestore.cgi',
      require => File['/home/gerrit2/review_site/lib'],
    }
  }

  # Remove libs installed by Gerrit init.
  tidy { '/home/gerrit2/review_site/lib':
    recurse => true,
    matches => ["bcprov-jdk*.jar", "bcpg-jdk*.jar", "bcpkix-jdk*.jar", "mysql-connector-java-*.jar"]
  }
}
