# gerrit::params
class gerrit::params (
){
  case $::lsbdistcodename {
    'trusty': {
      $jre_package = 'openjdk-7-jre-headless'
      $java_home = '/usr/lib/jvm/java-7-openjdk-amd64/jre'
    }
    'xenial': {
      $jre_package = 'openjdk-8-jre-headless'
      $java_home = '/usr/lib/jvm/java-8-openjdk-amd64/jre'
    }
    default: {
      fail("Operating system release ${::lsbdistcodename} not supported.")
    }
  }
}
