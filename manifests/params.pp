# Class: gerrit::params
#
# Gerrit Code Review params:
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
#   git_http_url:
#     Optional base URL for repositories available over the HTTP protocol
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
#   gc_start_time:
#     Start time to define the first execution of the git garbage collection
#   gc_interval:
#     Interval for periodic repetition of triggering the git garbage collection
#   core_loggingbuffersize:
#   core_packedgitopenfiles:
#   core_packedgitlimit:
#   core_packedgitwindowsize:
#   sshd_threads:
#   sshd_batch_threads:
#     Number of threads for SSH command requests from non-interactive users
#   sshd_listen_address:
#   sshd_idle_timeout:
#       Server automatically terminates idle connections after this time
#   sshd_max_connections_per_user:
#       Maximum number of concurrent SSH sessions a user account may open
#   httpd_acceptorthreads:
#   httpd_minthreads:
#   httpd_maxthreads:
#   httpd_maxqueued:
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
#   receive_max_object_size_limit
#     Maximum allowed Git object size that 'receive-pack' will accept.
#   download:
#     The allowed download commands and schemes.  The data structor for this
#     should be a hash with keys and array of values (i.e. {key => [values]})
#     Example:
#       download      => {
#           'command' => ['checkout', 'cherry_pick', 'pull', 'format_patch'],
#           'scheme'  => ['ssh', 'anon_http', 'anon_git'],
#           'archive' => ['tar', 'tbz2', 'tgz', 'txz'],
#       },
# TODO: make more gerrit options configurable here
#
class gerrit::params {
  $mysql_host = 'localhost',
  $mysql_password,
  $war = '',
  $email_private_key = '',
  $token_private_key = '',
  $vhost_name = $::fqdn,
  $redirect_to_canonicalweburl = true,
  $canonicalweburl = "https://${::fqdn}/",
  $git_http_url = '',
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
  $gc_start_time = '',
  $gc_interval = '',
  $core_loggingbuffersize = '',
  $core_packedgitlimit = '',
  $core_packedgitopenfiles = '',
  $core_packedgitwindowsize = '',
  $sshd_threads = '',
  $sshd_batch_threads = '',
  $sshd_listen_address = '*:29418',
  $sshd_idle_timeout = '',
  $sshd_max_connections_per_user = '',
  $httpd_acceptorthreads = '',
  $httpd_minthreads = '',
  $httpd_maxthreads = '',
  $httpd_maxqueued = '',
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
  $receive_max_object_size_limit = '',
  $cache_diff_timeout = '',
  $cache_diff_intraline_timeout = '',
  $download = {},
}
