# gerrit::params
class gerrit::params (
){
  case $::lsbdistcodename {
    'trusty': {
      $jre_package = 'openjdk-7-jre-headless'
    }
    'xenial': {
      $jre_package = 'openjdk-8-jre-headless'
    }
    default: {
      fail("Operating system release ${::lsbdistcodename} not supported.")
    }
  }
}
