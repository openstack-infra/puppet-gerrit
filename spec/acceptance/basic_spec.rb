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
    # debugging
    puts command('/bin/cat /etc/mysql/my.cnf').stdout
    puts command('/usr/bin/mysql reviewdb -e "select @@global.sql_mode;"').stdout
  end

  it 'should be idempotent' do
    pending("this module is not idempotent, yet.")
    apply_manifest(default_puppet_module, catch_changes: true)
  end

  describe 'user' do
    describe user('gerrit2') do
      it { should exist }
      it { should belong_to_group 'gerrit2' }
      it { should have_home_directory '/home/gerrit2' }
      it { should have_login_shell '/bin/bash' }
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
