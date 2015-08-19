require 'spec_helper_acceptance'

describe 'required files and directories' do
  describe file('/home/gerrit2/review_site/etc/gerrit.config') do
    it { should be_file }
    it { should contain('javaHome = /usr/lib/jvm/java-7-openjdk-amd64/jre') }
  end

  describe file('/home/gerrit2/review_site/etc/secure.config') do
    it { should be_file }
    it { should contain('password = 12345') }
  end

  describe file('/etc/default/gerritcodereview') do
    it { should be_file }
    it { should contain('GERRIT_SITE=/home/gerrit2/review_site') }
  end

  describe file('/etc/mysql/conf.d/client.conf') do
    it { should be_file }
    it { should contain('port          = 3306') }
  end

  describe file('/home/gerrit2/review_site/etc/ssh_host_rsa_key') do
    it { should be_file }
    it { should contain('-----BEGIN RSA PRIVATE KEY-----') }
  end

  describe file('/home/gerrit2/review_site/etc/ssh_host_rsa_key.pub') do
    it { should be_file }
    it { should contain('ssh-rsa') }
  end

  describe file('/home/gerrit2/review_site/etc/ssh_project_rsa_key') do
    it { should be_file }
    it { should contain('-----BEGIN RSA PRIVATE KEY-----') }
  end

  describe file('/home/gerrit2/review_site/etc/ssh_project_rsa_key.pub') do
    it { should be_file }
    it { should contain('ssh-rsa') }
  end

  describe file('/home/gerrit2/.ssh/id_rsa') do
    it { should be_file }
    it { should contain('-----BEGIN RSA PRIVATE KEY-----') }
  end

  describe file('/home/gerrit2/id_rsa.pub') do
    it { should be_file }
    it { should contain('ssh-rsa') }
  end
end
