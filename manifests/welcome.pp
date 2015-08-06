# == Class: gerrit::welcome
#
class gerrit::welcome (
    $ssh_welcome_rsa_key_contents,
    $ssh_welcome_rsa_pubkey_contents,
) {
  file { '/home/gerrit2/review_site/etc/ssh_welcome_rsa_key':
    owner   => 'gerrit2',
    group   => 'gerrit2',
    mode    => '0600',
    content => $ssh_welcome_rsa_key_contents,
    replace => true,
    require => File['/home/gerrit2/review_site/etc']
  }

  file { '/home/gerrit2/review_site/etc/ssh_welcome_rsa_key.pub':
    owner   => 'gerrit2',
    group   => 'gerrit2',
    mode    => '0644',
    content => $ssh_welcome_rsa_pubkey_contents,
    replace => true,
    require => File['/home/gerrit2/review_site/etc']
  }
}
