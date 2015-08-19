require 'spec_helper_acceptance'

describe 'operating system packages' do
  before(:all) do
    Puppet.apply
  end

  context 'installed packages' do
    describe package('apache2'), :if => os[:family] == 'ubuntu' do
      it { should be_installed }
    end

    describe package('httpd'), :if => os[:family] == 'redhat' do
      it { should be_installed }
    end

    describe package('gitweb') do
      it { should be_installed }
    end

    describe package('unzip') do
      it { should be_installed }
    end

    describe package('openjdk-7-jre-headless') do
      it { should be_installed }
    end

    describe package('libmysql-java') do
      it { should be_installed }
    end

    describe package('mysql-client') do
      it { should be_installed }
    end

    describe package('mysql-server') do
      it { should be_installed }
    end
  end

  context 'purged packages' do
    describe package('openjdk-6-jre-headless') do
      it { should_not be_installed }
    end
  end
end

