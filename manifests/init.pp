# Class: gerrit
class gerrit(
  $mysql_host = $::gerrit::params::mysql_host,
  $mysql_password = $::gerrit::params::mysql_password,
  $war = $::gerrit::params::war,
  $email_private_key = $::gerrit::params::email_private_key,
  $token_private_key = $::gerrit::params::token_private_key,
  $vhost_name = $::gerrit::params::vhost_name,
  $redirect_to_canonicalweburl = $::gerrit::params::redirect_to_canonicalweburl,
  $canonicalweburl = $::gerrit::params::canonicalweburl,
  $git_http_url = $::gerrit::params::git_http_url,
  $canonical_git_url = $::gerrit::params::canonical_git_url,
  $robots_txt_source = $::gerrit::params::robots_txt_source,
  $serveradmin = $::gerrit::params::serveradmin,
  $ssl_cert_file = $::gerrit::params::ssl_cert_file,
  $ssl_key_file = $::gerrit::params::ssl_key_file,
  $ssl_chain_file = $::gerrit::params::ssl_chain_file,
  $ssl_cert_file_contents = $::gerrit::params::ssl_cert_file_contents,
  $ssl_key_file_contents = $::gerrit::params::ssl_key_file_contents,
  $ssl_chain_file_contents = $::gerrit::params::ssl_chain_file_contents,
  $ssh_dsa_key_contents = $::gerrit::params::ssh_dsa_key_contents,
  $ssh_dsa_pubkey_contents = $::gerrit::params::ssh_dsa_pubkey_contents,
  $ssh_rsa_key_contents = $::gerrit::params::ssh_rsa_key_contents,
  $ssh_rsa_pubkey_contents = $::gerrit::params::ssh_rsa_pubkey_contents,
  $ssh_project_rsa_key_contents = $::gerrit::params::ssh_project_rsa_key_contents,
  $ssh_project_rsa_pubkey_contents = $::gerrit::params::ssh_project_rsa_pubkey_contents,
  $ssh_replication_rsa_key_contents = $::gerrit::params::ssh_replication_rsa_key_contents,
  $ssh_replication_rsa_pubkey_contents = $::gerrit::params::ssh_replication_rsa_pubkey_contents,
  $gerrit_auth_type = $::gerrit::params::gerrit_auth_type,
  $gerrit_contributor_agreement = $::gerrit::params::gerrit_contributor_agreement,
  $openidssourl = $::gerrit::params::openidssourl,
  $ldap_server = $::gerrit::params::ldap_server,
  $ldap_account_base = $::gerrit::params::ldap_account_base,
  $ldap_group_base = $::gerrit::params::ldap_group_base,
  $ldap_username = $::gerrit::params::ldap_username,
  $ldap_password = $::gerrit::params::ldap_password,
  $ldap_account_pattern = $::gerrit::params::ldap_account_pattern,
  $ldap_account_email_address = $::gerrit::params::ldap_account_email_address,
  $ldap_sslverify = $::gerrit::params::ldap_sslverify,
  $ldap_ssh_account_name = $::gerrit::params::ldap_ssh_account_name,
  $ldap_accountfullname = $::gerrit::params::ldap_accountfullname,
  $email = $::gerrit::params::email,
  $smtpserver = $::gerrit::params::smtpserver,
  $sendemail_from = $::gerrit::params::sendemail_from,
  $sendemail_include_diff = $::gerrit::params::sendemail_include_diff,
  $database_poollimit = $::gerrit::params::database_poollimit,
  $container_heaplimit = $::gerrit::params::container_heaplimit,
  $container_javaoptions = $::gerrit::params::container_javaoptions,
  $gc_start_time = $::gerrit::params::gc_start_time,
  $gc_interval = $::gerrit::params::gc_interval,
  $core_loggingbuffersize = $::gerrit::params::core_loggingbuffersize,
  $core_packedgitlimit = $::gerrit::params::core_packedgitlimit,
  $core_packedgitopenfiles = $::gerrit::params::core_packedgitopenfiles,
  $core_packedgitwindowsize = $::gerrit::params::core_packedgitwindowsize,
  $sshd_threads = $::gerrit::params::sshd_threads,
  $sshd_batch_threads = $::gerrit::params::sshd_batch_threads,
  $sshd_listen_address = $::gerrit::params::sshd_listen_address,
  $sshd_idle_timeout = $::gerrit::params::sshd_idle_timeout,
  $sshd_max_connections_per_user = $::gerrit::params::sshd_max_connections_per_user,
  $httpd_acceptorthreads = $::gerrit::params::httpd_acceptorthreads,
  $httpd_minthreads = $::gerrit::params::httpd_minthreads,
  $httpd_maxthreads = $::gerrit::params::httpd_maxthreads,
  $httpd_maxqueued = $::gerrit::params::httpd_maxqueued,
  $httpd_maxwait = $::gerrit::params::httpd_maxwait,
  $commentlinks = $::gerrit::params::commentlinks,
  $its_plugins = $::gerrit::params::its_plugins,
  $its_rules = $::gerrit::params::its_rules,
  $trackingids = $::gerrit::params::trackingids,
  $contactstore = $::gerrit::params::contactstore,
  $contactstore_appsec = $::gerrit::params::contactstore_appsec,
  $contactstore_pubkey = $::gerrit::params::contactstore_pubkey,
  $contactstore_url = $::gerrit::params::contactstore_url,
  $enable_melody = $::gerrit::params::enable_melody,
  $melody_session = $::gerrit::params::melody_session,
  $replicate_local = $::gerrit::params::replicate_local,
  $replicate_path = $::gerrit::params::replicate_path,
  $replication_force_update = $::gerrit::params::replication_force_update,
  $replication = $::gerrit::params::replication,
  $gitweb = $::gerrit::params::gitweb,
  $cgit = $::gerrit::params::cgit,
  $web_repo_url = $::gerrit::params::web_repo_url,
  $web_repo_url_encode = $::gerrit::params::web_repo_url_encode,
  $testmode = $::gerrit::params::testmode,
  $secondary_index = $::gerrit::params::secondary_index,
  $secondary_index_type = $::gerrit::params::secondary_index_type,
  $offline_reindex = $::gerrit::params::offline_reindex,
  $enable_javamelody_top_menu = $::gerrit::params::enable_javamelody_top_menu,
  $manage_jeepyb = $::gerrit::params::manage_jeepyb,
  $reindex_threads = $::gerrit::params::reindex_threads,
  $report_bug_text = $::gerrit::params::report_bug_text,
  $report_bug_url = $::gerrit::params::report_bug_url,
  $index_threads = $::gerrit::params::index_threads,
  $new_groups_visible_to_all = $::gerrit::params::new_groups_visible_to_all,
  $allow_drafts = $::gerrit::params::allow_drafts,
  $receive_max_object_size_limit = $::gerrit::params::receive_max_object_size_limit,
  $cache_diff_timeout = $::gerrit::params::cache_diff_timeout,
  $cache_diff_intraline_timeout = $::gerrit::params::cache_diff_intraline_timeout,
  $download = $::gerrit::params::download,
  $commitmessage_params = $::gerrit::params::commitmessage_params,
  $java_home = $::gerrit::params::java_home,
) inherits ::gerrit::params {
  include ::httpd

  if $manage_jeepyb {
    include ::jeepyb
  }
  include ::pip

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
  # - $git_http_url
  # - $canonical_git_url
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
  # - $gc_start_time
  # - $gc_interval
  # - $core_packedgitopenfiles
  # - $core_packedgitlimit
  # - $core_packedgitwindowsize
  # - $sshd_listen_address
  # - $sshd_threads
  # - $sshd_idle_timeout
  # - $sshd_max_connections_per_user
  # - $sshd_batch_threads
  # - $httpd_maxwait
  # - $httpd_acceptorthreads
  # - $httpd_minthreads
  # - $httpd_maxthreads
  # - $httpd_maxqueued
  # - $commentlinks
  # - $its_plugins
  # - $its_rules
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
  # - $offline_reindex:
  # - $reindex_threads:
  # - $index_threads:
  # - $new_groups_visible_to_all:
  # - $allow_drafts:
  # - $receive_max_object_size_limit
  # - $cache_diff_timeout
  # - $cache_diff_intraline_timeout
  # - $download
  # - $commitmessage_params

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

  # setup rules for its (issue tracking system) plugins
  file { '/home/gerrit2/review_site/etc/its':
    ensure  => 'directory',
    owner   => 'gerrit2',
    group   => 'gerrit2',
    mode    => '0644',
    require => File['/home/gerrit2/review_site/etc'],
  }
  file { '/home/gerrit2/review_site/etc/its/actions.config':
    ensure  => present,
    owner   => 'gerrit2',
    group   => 'gerrit2',
    mode    => '0644',
    content => template('gerrit/gerrit.its_rules.erb'),
    replace => true,
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
  httpd::mod { 'rewrite':
    ensure => present,
    before => Service['httpd'],
  }
  httpd::mod { 'proxy':
    ensure => present,
    before => Service['httpd'],
  }
  httpd::mod { 'proxy_http':
    ensure => present,
    before => Service['httpd'],
  }
  if ! defined(Httpd::Mod['cgid']) {
    httpd::mod { 'cgid':
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
  # We need to make the initial index for a fresh install.  By default
  # the gerrit init call will do that, but because we have
  # pre-populated various directories above, even a fresh install
  # looks like an upgrade and the init process leaves out the index.
  # Unless we create it, gerrit refuses to start with errors like
  #   1) No index versions ready; run Reindex
  exec { 'gerrit-initial-index':
    user        => 'gerrit2',
    command     => "/usr/bin/java -jar ${gerrit_war} reindex -d ${gerrit_site} --threads ${reindex_threads}",
    subscribe   => [Exec['gerrit-initial-init']],
    refreshonly => true,
    logoutput   => true,
  }

  # We can now online reindex, so no need to run this on upgrades by
  # default.
  if ($offline_reindex) {
    exec { 'gerrit-reindex':
      user        => 'gerrit2',
      command     => "/usr/bin/java -jar ${gerrit_war} reindex -d ${gerrit_site} --threads ${reindex_threads}",
      subscribe   => [File['/home/gerrit2/review_site/bin/gerrit.war'],
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

  $mysql_data = load_module_metadata('mysql', true)
  if $mysql_data == {} {
    package { 'mysql-client':
      ensure => present,
      before => File['/etc/mysql/conf.d/client.conf'],
    }
  } else {
    include ::mysql::client
    Class['::mysql::client'] -> File['/etc/mysql/conf.d/client.conf']
  }
  # Add config to make clients assume UTF-8 encoding
  file { '/etc/mysql/conf.d/client.conf':
    ensure  => present,
    source  => 'puppet:///modules/gerrit/my.cnf',
    replace => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
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
