# Install and maintain Gerrit Code Review.
# params:
#   mysql_host:
#     The mysql host to which gerrit should connect.
#   mysql_password:
#     The password with which gerrit connects to mysql.
#   vhost_name:
#     used in the Apache virtual host, eg., review.example.com
#   redirect_to_canonicalweburl:
#     Boolean value to determine whether or not mod_rewrite should redirect
#     requests to the canonicalweburl
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
#   sendemail_indclude_diff:
#     Config emails to includes the complete unified diff of the change
#   database_poollimit:
#   container_heaplimit:
#   container_javaoptions:
#   core_loggingbuffersize:
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
#   replication_force_update:
#     A boolean enabling replication to force updates to remote
#   replicate_path:
#     The path to the local git replica if replicate_local is enabled
#   gitweb:
#     A boolean enabling gitweb
#   cgit:
#     A boolean enabling cgit
#   web_repo_url:
#     Url for setting the location of an external git browser
#   web_repo_url_encode:
#     Whether or not Gerrit should encode the generated viewer URL.
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
#   reindex_threads:
#     The number of threads to use for full offline reindexing of Gerrit data
#   index_threads:
#     Number of threads to use for indexing in normal interactive operations
#   allow_drafts:
#     Set this to false to disable drafts feature
# TODO: make more gerrit options configurable here
#
class gerrit(
  $mysql_host = 'localhost',
  $mysql_password,
  $war = '',
  $email_private_key = '',
  $token_private_key = '',
  $vhost_name = $::fqdn,
  $redirect_to_canonicalweburl = true,
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
  $ldap_group_base = '',
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
  $sendemail_include_diff = false,
  $database_poollimit = '',
  $container_heaplimit = '',
  $container_javaoptions = '',
  $core_loggingbuffersize = '',
  $core_packedgitlimit = '',
  $core_packedgitopenfiles = '',
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
  $replication_force_update = true,
  $replication = [],
  $gitweb = true,
  $cgit = false,
  $web_repo_url = '',
  $web_repo_url_encode = true,
  $testmode = false,
  $secondary_index = false,
  $secondary_index_type = 'LUCENE',
  $enable_javamelody_top_menu = false,
  $manage_jeepyb = true,
  $reindex_threads = $::processorcount/2,
  $report_bug_text = 'Report Bug',
  $report_bug_url = '',
  $index_threads = 1,
  $new_groups_visible_to_all = true,
  $allow_drafts = true,
) {
  include ::httpd

  if $manage_jeepyb {
    include ::jeepyb
  }
  include ::pip

  $java_home = $::lsbdistcodename ? {
    'precise' => '/usr/lib/jvm/java-7-openjdk-amd64/jre',
    'trusty'  => '/usr/lib/jvm/java-7-openjdk-amd64/jre',
  }

  # get the war version from the passed in url, expecting something like
  # http://tarballs.openstack.org/ci/gerrit/gerrit-v2.10.2.22.acc615e.war
  $split1 = split($war, '/')
  $split2 = split($split1[-1], 'gerrit-v')
  $split3 = split($split2[-1],'.war')
  $gerrit_war_filename = $split1[-1]  # like gerrit-v2.10.2.22.acc615e.war
  $gerrit_war_version = $split3[0]  # like 2.10.2.22.acc615e

  $gerrit_war = '/home/gerrit2/review_site/bin/gerrit.war'
  $gerrit_site = '/home/gerrit2/review_site'

  include ::gerrit::user

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
  # - $smtpserver
  # - $sendemail_from
  # - $sendemail_include_diff
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
  # - $container_javaoptions
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
  # - web_repo_url
  # - web_repo_url_encode
  # - $contactstore_appsec
  # - $contactstore_url
  # - $report_bug_text
  # - $report_bug_url
  # - $secondary_index_type:
  # - $reindex_threads:
  # - $index_threads:
  # - $new_groups_visible_to_all:
  # - $allow_drafts:
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
  # Template uses $mysql_password, $email_private_key and $token_private_key
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
  # - $redirect_to_canonicalweburl
  # - $replicate_local
  # - $replicate_path
  # - $contactstore
  # - $robots_txt_source
  ::httpd::vhost { $vhost_name:
    port     => 443,
    docroot  => 'MEANINGLESS ARGUMENT',
    priority => '50',
    template => 'gerrit/gerrit.vhost.erb',
    ssl      => true,
  }
  httpd_mod { 'rewrite':
    ensure => present,
    before => Service['httpd'],
  }
  httpd_mod { 'proxy':
    ensure => present,
    before => Service['httpd'],
  }
  httpd_mod { 'proxy_http':
    ensure => present,
    before => Service['httpd'],
  }
  if ! defined(Httpd_mod['cgi']) {
    httpd_mod { 'cgi':
      ensure => present,
      before => Service['httpd'],
    }
  }

  if $ssl_cert_file_contents != '' {
    file { $ssl_cert_file:
      owner   => 'root',
      group   => 'root',
      mode    => '0640',
      content => $ssl_cert_file_contents,
      before  => Httpd::Vhost[$vhost_name],
    }
  }

  if $ssl_key_file_contents != '' {
    file { $ssl_key_file:
      owner   => 'root',
      group   => 'ssl-cert',
      mode    => '0640',
      content => $ssl_key_file_contents,
      before  => Httpd::Vhost[$vhost_name],
    }
  }

  if $ssl_chain_file_contents != '' {
    file { $ssl_chain_file:
      owner   => 'root',
      group   => 'root',
      mode    => '0640',
      content => $ssl_chain_file_contents,
      before  => Httpd::Vhost[$vhost_name],
    }
  }

  if $robots_txt_source != '' {
    file { '/home/gerrit2/review_site/static/robots.txt':
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      source  => $robots_txt_source,
      require => File['/home/gerrit2/review_site/static'],
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
    command     => "/usr/bin/java -jar ${gerrit_war} init -d ${gerrit_site} --batch --no-auto-start",
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

  if ($secondary_index) {
    exec { 'gerrit-reindex':
      user        => 'gerrit2',
      command     => "/usr/bin/java -jar ${gerrit_war} reindex -d ${gerrit_site} --threads ${reindex_threads}",
      subscribe   => [File['/home/gerrit2/review_site/bin/gerrit.war'],
                      Exec['gerrit-initial-init'],
                      Exec['gerrit-init']],
      refreshonly => true,
      logoutput   => true,
    }
  }

  # If a new gerrit.war was just installed, run the Gerrit "init" command.
  # Stop is included here because it may not be running or the init
  # script may not exist, and in those cases, we don't care if it fails.
  # Running the init script as the gerrit2 user _does_ work.
  exec { 'gerrit-init':
    user        => 'gerrit2',
    command     => "/etc/init.d/gerrit stop; /usr/bin/java -jar ${gerrit_war} init -d ${gerrit_site} --batch --no-auto-start",
    subscribe   => File['/home/gerrit2/review_site/bin/gerrit.war'],
    refreshonly => true,
    require     => [Package['openjdk-7-jre-headless'],
                    User['gerrit2'],
                    File['/home/gerrit2/review_site/etc/gerrit.config'],
                    File['/home/gerrit2/review_site/etc/secure.config']],
    onlyif      => '/usr/bin/test -f /etc/init.d/gerrit',
    notify      => Exec['install-core-plugins'],
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

  # Ensure only one set of bouncy castle libs are installed
  # and remove libs installed by Gerrit init.
  if versioncmp($gerrit_war_version, '2.10') > 0 {
    # Remove libs for Gerrit 2.9 and lower
    tidy { '/home/gerrit2/review_site/lib':
      recurse => true,
      matches => ['bcprov-jdk*.jar',
                  'bcpg-jdk*.jar',
                  'bcpkix-jdk*.jar',
                  'mysql-connector-java-*.jar',
                  'bcprov.jar',
                  'bcpg.jar',
                  'bcpkix.jar'],
      before  => Exec['gerrit-start'],
    }
  } else {
    # Remove libs for Gerrit 2.10+
    tidy { '/home/gerrit2/review_site/lib':
      recurse => true,
      matches => ['bcprov-jdk*.jar',
                  'bcpg-jdk*.jar',
                  'bcpkix-jdk*.jar',
                  'mysql-connector-java-*.jar',
                  'bcprov-*.jar',
                  'bcpg-*.jar',
                  'bcpkix-*.jar'],
      before  => Exec['gerrit-start'],
    }
  }

  class { '::httpd::logrotate':
    options => [
      'daily',
      'missingok',
      'rotate 30',
      'compress',
      'delaycompress',
      'notifempty',
      'create 640 root adm',
      'sharedscripts',
    ],
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
    require     => [File['/etc/init.d/gerrit'],
                    Tidy['/home/gerrit2/review_site/lib']],
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
    before  => Exec['gerrit-start'],
    require => [
      Package['libmysql-java'],
      File['/home/gerrit2/review_site/lib'],
    ],
  }

  package { 'mysql-client':
    ensure => present,
  }
  # Add config to make clients assume UTF-8 encoding
  file { '/etc/mysql/conf.d/client.conf':
    ensure  => present,
    source  => 'puppet:///modules/gerrit/my.cnf',
    replace => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['mysql-client'],
  }

  # Gerrit 2.10 requires libs not available in ubuntu repositories
  # need to download them directly from maven central.
  if versioncmp($gerrit_war_version, '2.10') > 0 {
    exec { 'download bcprov-jdk15on-1.51.jar':
      command => '/usr/bin/wget https://repo1.maven.org/maven2/org/bouncycastle/bcprov-jdk15on/1.51/bcprov-jdk15on-1.51.jar -O /home/gerrit2/review_site/lib/bcprov-1.51.jar',
      creates => '/home/gerrit2/review_site/lib/bcprov-1.51.jar',
      before  => Exec['gerrit-start'],
      require => File['/home/gerrit2/review_site/lib'],
    }
    exec { 'download bcpkix-jdk15on-1.51.jar':
      command => '/usr/bin/wget https://repo1.maven.org/maven2/org/bouncycastle/bcpkix-jdk15on/1.51/bcpkix-jdk15on-1.51.jar -O /home/gerrit2/review_site/lib/bcpkix-1.51.jar',
      creates => '/home/gerrit2/review_site/lib/bcpkix-1.51.jar',
      before  => Exec['gerrit-start'],
      require => File['/home/gerrit2/review_site/lib'],
    }
  } else {
    package { 'libbcprov-java':
      ensure => present,
    }
    file { '/home/gerrit2/review_site/lib/bcprov.jar':
      ensure  => link,
      target  => '/usr/share/java/bcprov.jar',
      before  => Exec['gerrit-start'],
      require => [
        Package['libbcprov-java'],
        File['/home/gerrit2/review_site/lib'],
      ],
    }

    # Required for the version of Bouncy Castle on Trusty and later
    if ($::lsbdistcodename != 'precise') {
      package { 'libbcpkix-java':
        ensure => present,
      }
      file { '/home/gerrit2/review_site/lib/bcpkix.jar':
        ensure  => link,
        target  => '/usr/share/java/bcpkix.jar',
        before  => Exec['gerrit-start'],
        require => [
          Package['libbcpkix-java'],
          File['/home/gerrit2/review_site/lib'],
        ],
      }
    }
  }

  # Install Bouncy Castle's OpenPGP plugin and populate the contact store
  # public key file if we're using that feature.
  if ($contactstore == true) {
    if versioncmp($gerrit_war_version, '2.10') > 0 {
      exec { 'download bcpgjdk15on-1.51.jar':
        command => '/usr/bin/wget https://repo1.maven.org/maven2/org/bouncycastle/bcpg-jdk15on/1.51/bcpg-jdk15on-1.51.jar -O /home/gerrit2/review_site/lib/bcpg-1.51.jar',
        creates => '/home/gerrit2/review_site/lib/bcpg-1.51.jar',
        before  => Exec['gerrit-start'],
        require => File['/home/gerrit2/review_site/lib'],
      }
    } else {
      package { 'libbcpg-java':
        ensure => present,
      }
      file { '/home/gerrit2/review_site/lib/bcpg.jar':
        ensure  => link,
        target  => '/usr/share/java/bcpg.jar',
        before  => Exec['gerrit-start'],
        require => [
          Package['libbcpg-java'],
          File['/home/gerrit2/review_site/lib'],
        ],
      }
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

  # create local replication directory if needed
  if $replicate_local {
    file { $replicate_path:
      ensure => directory,
      owner  => 'gerrit2',
    }
  }
}
