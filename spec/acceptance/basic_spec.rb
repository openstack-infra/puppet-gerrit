require 'spec_helper_acceptance'

describe 'basic gerrit', :if => ['debian', 'ubuntu'].include?(os[:family]) do
  def pp_path
    base_path = File.dirname(__FILE__)
    File.join(base_path, 'fixtures')
  end

  def preconditions_puppet_module
    module_path = File.join(pp_path, 'preconditions.pp')
    File.read(module_path)
  end

  def default_puppet_module
    module_path = File.join(pp_path, 'default.pp')
    File.read(module_path)
  end

  before(:all) do
    apply_manifest(preconditions_puppet_module, catch_failures: true)
  end

  it 'should work with no errors' do
    apply_manifest(default_puppet_module, catch_failures: true)
  end

  it 'should be idempotent' do
    pending("this module is not idempotent, yet.")
    apply_manifest(default_puppet_module, catch_changes: true)
  end

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

  describe 'user' do
    describe user('gerrit2') do
      it { should exist }
      it { should belong_to_group 'gerrit2' }
      it { should have_home_directory '/home/gerrit2' }
      it { should have_login_shell '/bin/bash' }
    end
  end

  describe 'required packages' do
    installed_packages = [
      'gitweb',
      'unzip',
      'openjdk-7-jre-headless',
      'libmysql-java',
      'mysql-client',
      'mysql-server'
    ]

    installed_packages.each do |package|
      describe package(package) do
        it { should be_installed }
      end
    end

    unnecessary_packages = ['openjdk-6-jre-headless']
    unnecessary_packages.each do |package|
      describe package(package) do
        it { should_not be_installed }
      end
    end
  end

  describe 'required services' do
    describe port(80) do
      it { should be_listening }
    end

    describe command("curl http://localhost --insecure --location") do
      its(:stdout) { should contain('Gerrit Code Review') }
      its(:stdout) { should contain('"version":"2.11.4-13-gcb9800e"') }
    end

    describe port(443) do
      it { should be_listening }
    end

    describe command("curl https://localhost --insecure --location") do
      its(:stdout) { should contain('Gerrit Code Review') }
      its(:stdout) { should contain('"version":"2.11.4-13-gcb9800e"') }
    end

    describe port(8081) do
      it { should be_listening }
    end

    describe port(29418) do
      it { should be_listening }
    end
  end
end
