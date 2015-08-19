require 'spec_helper_acceptance'

describe 'operating system services' do
  before(:all) do
    Puppet.apply
  end

  describe file('/etc/init.d/apache2') do
    it { should exist }
  end

  describe file('/etc/init.d/gerrit') do
    it { should exist }
  end

  describe port(8081) do
    it { should be_listening }
  end
end
