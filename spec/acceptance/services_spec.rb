require 'spec_helper_acceptance'

describe 'operating system services' do
  describe service('apache2'), :if => ['debian', 'ubuntu'].include?(os[:family]) do
    it { should be_enabled }
    it { should be_running }
  end

  describe service('httpd'), :if => os[:family] == 'redhat' do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(80) do
    it { should be_listening }
  end

  describe command("curl http://localhost:80") do
    its(:stdout) { should contain('302 Found') }
    its(:stdout) { should contain('The document has moved') }
  end

  describe port(443) do
    it { should be_listening }
  end

  describe command("curl https://localhost:443 --insecure") do
    its(:stdout) { should contain('302 Found') }
    its(:stdout) { should contain('The document has moved') }
  end

  describe port(8081) do
    it { should be_listening }
  end

  describe command("curl http://localhost:8081") do
    its(:stdout) { should contain('Gerrit Code Review') }
    its(:stdout) { should contain('version":"2.8.4-19-g4548330') }
  end

  describe port(29418) do
    it { should be_listening }
  end
end
